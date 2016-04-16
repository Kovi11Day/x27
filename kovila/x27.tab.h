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
     OPEN = 264,
     CLOSE = 265,
     NUM = 266,
     IF = 267,
     CONDITION = 268,
     THEN = 269,
     ELSE = 270,
     ARITH_EXPR = 271,
     LET = 272,
     REC = 273,
     IN = 274,
     WHERE = 275
   };
#endif
/* Tokens.  */
#define KEY 258
#define VALUE 259
#define TAG 260
#define TEXT 261
#define IDEN 262
#define EMPTY_NODE 263
#define OPEN 264
#define CLOSE 265
#define NUM 266
#define IF 267
#define CONDITION 268
#define THEN 269
#define ELSE 270
#define ARITH_EXPR 271
#define LET 272
#define REC 273
#define IN 274
#define WHERE 275




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 13 "x27.y"
{
  char* name;
  int value;
  struct ast* ast;
  struct attributes* attr;
 }
/* Line 1529 of yacc.c.  */
#line 96 "x27.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

