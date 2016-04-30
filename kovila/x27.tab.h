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
     IDEN = 258,
     ATTR_FOUND = 259,
     OPEN = 260,
     CLOSE = 261,
     NUM = 262,
     OPEN_FOREST = 263,
     IF = 264,
     CONDITION = 265,
     THEN = 266,
     ELSE = 267,
     ARITH_EXPR = 268,
     LET = 269,
     REC = 270,
     IN = 271,
     WHERE = 272,
     WITH = 273,
     EMITT = 274,
     TAG = 275,
     KEY = 276,
     VALUE = 277,
     TEXT = 278,
     EMPTY_NODE = 279
   };
#endif
/* Tokens.  */
#define IDEN 258
#define ATTR_FOUND 259
#define OPEN 260
#define CLOSE 261
#define NUM 262
#define OPEN_FOREST 263
#define IF 264
#define CONDITION 265
#define THEN 266
#define ELSE 267
#define ARITH_EXPR 268
#define LET 269
#define REC 270
#define IN 271
#define WHERE 272
#define WITH 273
#define EMITT 274
#define TAG 275
#define KEY 276
#define VALUE 277
#define TEXT 278
#define EMPTY_NODE 279




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
#line 104 "x27.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

