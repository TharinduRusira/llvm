; RUN: opt -S -instcombine < %s | FileCheck %s

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

; CHECK-LABEL: @mult(
define i32 @mul()() local_unnamed_addr #0 prologue <{ i32, i8* }> <{ i32 1413876459, i8* bitcast ({ i8*, i8* }* @typeinfo for int () to i8*) }> !dbg !6 {
	tail call void @llvm.dbg.value(metadata i32 1, i64 0, metadata !11, metadata !14), !dbg !15
    tail call void @llvm.dbg.value(metadata i32 1, i64 0, metadata !12, metadata !14), !dbg !16
	br label %2, !dbg !17

; <label>:1:                                      ; preds = %10
    ret i32 %6, !dbg !20

; <label>:2:                                      ; preds = %10, %0
	%3 = phi i64 [ 1, %0 ], [ %11, %10 ]
	%4 = phi i32 [ 1, %0 ], [ %6, %10 ]
	%5 = tail call { i32, i1 } @llvm.smul.with.overflow.i32(i32 %4, i32 2), !dbg !21
	%6 = extractvalue { i32, i1 } %5, 0, !dbg !21
	%7 = extractvalue { i32, i1 } %5, 1, !dbg !21
	br i1 %7, label %8, label %10, !dbg !21, !prof !23, !nosanitize !2
; <label>:8:                                      ; preds = %2
	%9 = zext i32 %4 to i64, !dbg !24, !nosanitize !2
	tail call void @__ubsan_handle_mul_overflow(i8* bitcast ({ { [55 x i8]*, i32, i32 }, { i16, i16, [6 x i8] }* }* @1 to i8*), i64 %9, i64 2) #3, !dbg !24, !nosanitize !2
	br label %10, !dbg !24, !nosanitize !2

; <label>:10:                                     ; preds = %8, %2
	tail call void @llvm.dbg.value(metadata i32 %6, i64 0, metadata !11, metadata !14), !dbg !15
	%11 = add nuw nsw i64 %3, 1, !dbg !17
	%12 = icmp eq i64 %11, 31, !dbg !17
	br i1 %12, label %1, label %2, !dbg !17
}

