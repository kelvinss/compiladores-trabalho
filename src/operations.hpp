#if !defined(OPERATIONS_H)
#define OPERATIONS_H

/**
 * @file operations.hpp
 *
 * Type checking, type converstion and building AST nodes on expressions
 */

#include "ast.hpp"
#include "types.hpp"

namespace ops {
using ast::Expr;
using ast::Exprs;
using types::Type;

Type* unify_arith(const Type* l, const Type* r, const char* op);
Type* unify_comp(const Type* l, const Type* r, const char* op);
Type* unify_bitwise(const Type* l, const Type* r, const char* op);
Type* unary_verify(const Type* u, const char* op);
Type* btnot_verify(const Type* u, const char* op);

Expr* unify_additive(
    Expr* node1, Expr* node2, ast::BinConstructor constr, const char* op);

Expr* check_assignment(Type* target_type, Expr* value);
Expr* unify_assignment(Expr* target, Expr* value);

Expr* address_of(Expr* value);
Expr* derreference(Expr* value);
Expr* index_access(Expr* value, Expr* index);
Expr* function_call(Expr* value, ast::Exprs* parameters);

}; // namespace ops

#endif /* OPERATIONS_H */
