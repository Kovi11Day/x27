/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     KEY = 258,
     VALUE = 259,
     TAG = 260,
     TEXT = 261,
     IDEN = 262,
     EMPTY_NODE = 263,
     ATTR_FOUND = 264,
     OPEN = 265,
     CLOSE = 266,
     NUM = 267,
     IF = 268,
     CONDITION = 269,
     THEN = 270,
     ELSE = 271,
     ARITH_EXPR = 272,
     LET = 273,
     REC = 274,
     IN = 275,
     WHERE = 276,
     WITH = 277
   };
#endif
/* Tokens.  */
#define KEY 258
#define VALUE 259
#define TAG 260
#define TEXT 261
#define IDEN 262
#define EMPTY_NODE 263
#define ATTR_FOUND 264
#define OPEN 265
#define CLOSE 266
#define NUM 267
#define IF 268
#define CONDITION 269
#define THEN 270
#define ELSE 271
#define ARITH_EXPR 272
#define LET 273
#define REC 274
#define IN 275
#define WHERE 276
#define WITH 277




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 16 "x27.y"
{
  char* name;
  int value;
  struct ast* ast;
  struct attributes* attr;
 }
/* Line 1529 of yacc.c.  */
#line 100 "x27.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

