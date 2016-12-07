; RUN: opt -S -instcombine < %s | FileCheck %s

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

; CHECK-LABEL: @mult(
define i32 @mult(int, int)(i32 %a, i32 %b) #0 prefix <{ i32, i8* }> <{ i32 1413876459, i8* bitcast ({ i8*, i8* }* @typeinfo for int (int, int) to i8*) }> {
 
	%1 = alloca i32, align 4
    %2 = alloca i32, align 4
	store i32 %a, i32* %1, align 4
	store i32 %b, i32* %2, align 4
	%3 = load i32* %1, align 4
	%4 = and i32 %3, 255
	store i32 %4, i32* %1, align 4
	%5 = load i32* %2, align 4
	%6 = and i32 %5, 255
	store i32 %6, i32* %2, align 4
	%7 = load i32* %1, align 4
	%8 = load i32* %2, align 4
	%9 = call { i32, i1 } @llvm.smul.with.overflow.i32(i32 %7, i32 %8), !dbg !18
	%10 = extractvalue { i32, i1 } %9, 0
	%11 = extractvalue { i32, i1 } %9, 1
	%12 = xor i1 %11, true
	br i1 %12, label %16, label %13

; <label>:13   ; preds = %0
    %14 = zext i32 %7 to i64
	%15 = zext i32 %8 to i64
	call void @__ubsan_handle_mul_overflow(i8* bitcast ({ { [56 x i8]*, i32, i32 }, { i16, i16, [6 x i8] }* }* @1 to i8*), i64 %14, i64 %15) #3
	br label %16

; <label>:16	; preds = %13, %0
    ret i32 %10
}

