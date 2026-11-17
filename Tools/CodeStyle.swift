import Foundation
import SwiftParser
import SwiftSyntax

final class CodeStyle: SyntaxVisitor {
    private let locations: SourceLocationConverter
    private(set) var violationCount = 0

    init(file: String, tree: SourceFileSyntax) {
        locations = SourceLocationConverter(fileName: file, tree: tree)
        super.init(viewMode: .sourceAccurate)
    }

    override func visit(_ file: SourceFileSyntax) -> SyntaxVisitorContinueKind {
        _ = checkTypes(file.statements, startingAt: 0)
        return .visitChildren
    }

    private func checkTypes(_ statements: CodeBlockItemListSyntax, startingAt count: Int) -> Int {
        var count = count
        for statement in statements {
            let item = statement.item
            if let conditional = item.as(IfConfigDeclSyntax.self) {
                count = conditional.clauses.compactMap { clause in
                    clause.elements?.as(CodeBlockItemListSyntax.self).map { checkTypes($0, startingAt: count) }
                }.max() ?? count
            } else if item.is(TypeAliasDeclSyntax.self) || (item.isProtocol(DeclGroupSyntax.self) && !item.is(ExtensionDeclSyntax.self)) {
                count += 1
                if count > 2 {
                    report(item, "Keep at most two top-level types in one file.")
                }
            }
        }
        return count
    }

    override func visit(_ members: MemberBlockItemListSyntax) -> SyntaxVisitorContinueKind {
        for (previous, next) in zip(members, members.dropFirst()) {
            guard let first = isTypeMember(previous.decl), let second = isTypeMember(next.decl), first != second else {
                continue
            }
            let gap = previous.trailingTrivia.description + next.leadingTrivia.description
            if gap.range(of: #"\R\h*\R"#, options: .regularExpression) == nil {
                report(next, "Separate type members from instance members with a blank line.")
            }
        }
        return .visitChildren
    }

    private func isTypeMember(_ decl: DeclSyntax) -> Bool? {
        guard decl.is(VariableDeclSyntax.self) || decl.is(FunctionDeclSyntax.self) || decl.is(InitializerDeclSyntax.self)
            || decl.is(DeinitializerDeclSyntax.self) || decl.is(SubscriptDeclSyntax.self) else {
            return nil
        }
        return decl.asProtocol(WithModifiersSyntax.self)?.modifiers.contains {
            $0.name.tokenKind == .keyword(.static) || $0.name.tokenKind == .keyword(.class)
        }
    }

    override func visit(_ block: AccessorBlockSyntax) -> SyntaxVisitorContinueKind {
        switch block.accessors {
            case .getter:
                checkAccessor(block.leftBrace, block.rightBrace)
            case let .accessors(accessors):
                for accessor in accessors where ![.keyword(.willSet), .keyword(.didSet)].contains(accessor.accessorSpecifier.tokenKind) {
                    if let body = accessor.body {
                        checkAccessor(body.leftBrace, body.rightBrace)
                    }
                }
            @unknown default:
                break
        }
        return .visitChildren
    }

    private func checkAccessor(_ start: TokenSyntax, _ end: TokenSyntax) {
        let startLine = locations.location(for: start.positionAfterSkippingLeadingTrivia).line
        let endLine = locations.location(for: end.positionAfterSkippingLeadingTrivia).line
        if startLine == endLine {
            report(start, "Write the accessor body on separate lines.")
        }
    }

    private func report(_ syntax: some SyntaxProtocol, _ message: String) {
        let location = locations.location(for: syntax.positionAfterSkippingLeadingTrivia)
        print("\(location.file):\(location.line):\(location.column): warning: \(message)")
        violationCount += 1
    }
}

let arguments = CommandLine.arguments.dropFirst()
var violations = 0

for file in arguments where file != "--strict" {
    let tree = Parser.parse(source: try String(contentsOfFile: file, encoding: .utf8))
    let checker = CodeStyle(file: file, tree: tree)
    checker.walk(tree)
    violations += checker.violationCount
}
if arguments.contains("--strict"), violations > 0 {
    exit(1)
}
