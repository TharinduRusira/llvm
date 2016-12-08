; RUN: opt < %s | FileCheck %s

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

; CHECK-LABEL: @mult(
define i32 @mul(){

	br label %2

; <label>:1:                                      ; preds = %10
    ret i32 %6

; <label>:2:                                      ; preds = %10, %0
	%3 = phi i64 [ 1, %0 ], [ %11, %10 ]
	%4 = phi i32 [ 1, %0 ], [ %6, %10 ] 
	%5 = call { i32, i1 } @llvm.smul.with.overflow.i32(i32 %4, i32 2)
; CHECK-NOT: call {i32, i1} @llvm.smul.with.overflow.i32(i32 %4, i32 2)

	%6 = extractvalue { i32, i1 } %5, 0
	%7 = extractvalue { i32, i1 } %5, 1

	br i1 %7, label %8, label %10
; <label>:8:                                      ; preds = %2
	%9 = zext i32 %4 to i64
	br label %10

; <label>:10:                                     ; preds = %8, %2

	%11 = add nuw nsw i64 %3, 1
	%12 = icmp eq i64 %11, 30
	br i1 %12, label %1, label %2
}

