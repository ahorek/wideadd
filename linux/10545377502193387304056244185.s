	.text
	.amdgcn_target "amdgcn-amd-amdhsa--gfx1100"
	.p2align	2                               ; -- Begin function uint96_add_64
	.type	uint96_add_64,@function
uint96_add_64:                          ; @uint96_add_64
; %bb.0:
	s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
	v_add_co_u32 v0, vcc_lo, v3, v0
	v_add_co_ci_u32_e32 v1, vcc_lo, v4, v1, vcc_lo
	s_delay_alu instid0(VALU_DEP_1)
	v_cmp_lt_u64_e32 vcc_lo, v[0:1], v[3:4]
	v_add_co_ci_u32_e32 v2, vcc_lo, 0, v2, vcc_lo
	s_setpc_b64 s[30:31]
.Lfunc_end0:
	.size	uint96_add_64, .Lfunc_end0-uint96_add_64
                                        ; -- End function
	.section	.AMDGPU.csdata,"",@progbits
; Function info:
; codeLenInByte = 32
; NumSgprs: 34
; NumVgprs: 5
; ScratchSize: 0
; MemoryBound: 0
	.text
	.protected	test_uint96_add_64      ; -- Begin function test_uint96_add_64
	.globl	test_uint96_add_64
	.p2align	8
	.type	test_uint96_add_64,@function
test_uint96_add_64:                     ; @test_uint96_add_64
; %bb.0:
	s_clause 0x1
	s_load_b32 s8, s[0:1], 0x14
	s_load_b64 s[4:5], s[0:1], 0x30
	v_dual_mov_b32 v5, v0 :: v_dual_mov_b32 v6, 1
	v_dual_mov_b32 v7, 0 :: v_dual_mov_b32 v0, 1
	v_dual_mov_b32 v1, 0 :: v_dual_mov_b32 v2, 2
	v_dual_mov_b32 v3, 3 :: v_dual_mov_b32 v4, 0
	s_add_u32 s6, s0, 8
	s_addc_u32 s7, s1, 0
	s_mov_b32 s32, 0
	s_getpc_b64 s[2:3]
	s_add_u32 s2, s2, uint96_add_64@rel32@lo+4
	s_addc_u32 s3, s3, uint96_add_64@rel32@hi+12
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_3) | instid1(VALU_DEP_1)
	s_swappc_b64 s[30:31], s[2:3]
	v_cmp_ne_u64_e32 vcc_lo, 4, v[0:1]
	v_cmp_ne_u32_e64 s2, 2, v2
	s_mov_b32 s5, exec_lo
	s_or_b32 s2, vcc_lo, s2
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_and_b32 s2, s2, exec_lo
	s_cmov_b32 exec_lo, s2
	s_cbranch_scc0 .LBB1_10
; %bb.1:
	s_load_b64 s[2:3], s[6:7], 0x48
	s_mov_b32 s10, 0
                                        ; implicit-def: $sgpr11
                                        ; implicit-def: $sgpr13
                                        ; implicit-def: $sgpr12
	s_waitcnt lgkmcnt(0)
	s_load_b32 s9, s[2:3], 0x4
	global_load_b32 v0, v7, s[2:3] glc
	s_set_inst_prefetch_distance 0x1
	s_branch .LBB1_3
	.p2align	6
.LBB1_2:                                ; %Flow126
                                        ;   in Loop: Header=BB1_3 Depth=1
	s_and_b32 s14, exec_lo, s13
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_or_b32 s10, s14, s10
	s_and_not1_b32 s11, s11, exec_lo
	s_and_b32 s14, s12, exec_lo
	s_or_b32 s11, s11, s14
	s_and_not1_b32 s14, exec_lo, s10
	s_delay_alu instid0(SALU_CYCLE_1)
	s_cselect_b32 exec_lo, s14, s10
	s_cbranch_scc0 .LBB1_5
.LBB1_3:                                ; =>This Inner Loop Header: Depth=1
	s_waitcnt vmcnt(0)
	v_mov_b32_e32 v1, v0
	s_or_b32 s12, s12, exec_lo
	s_or_b32 s13, s13, exec_lo
	s_mov_b32 s14, exec_lo
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_1) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v0, 12, v1
	s_waitcnt lgkmcnt(0)
	v_cmp_ge_u32_e32 vcc_lo, s9, v0
                                        ; implicit-def: $vgpr0
	s_cmp_lg_u32 vcc_lo, 0
	s_cmov_b32 exec_lo, vcc_lo
	s_cbranch_scc0 .LBB1_2
; %bb.4:                                ;   in Loop: Header=BB1_3 Depth=1
	v_add_nc_u32_e32 v0, 4, v1
	s_and_not1_b32 s13, s13, exec_lo
	s_and_not1_b32 s12, s12, exec_lo
	global_atomic_cmpswap_b32 v0, v7, v[0:1], s[2:3] glc
	s_waitcnt vmcnt(0)
	v_cmp_eq_u32_e32 vcc_lo, v0, v1
	s_and_b32 s16, vcc_lo, exec_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_or_b32 s13, s13, s16
	s_or_b32 exec_lo, exec_lo, s14
	s_branch .LBB1_2
.LBB1_5:                                ; %loop.exit.guard
	s_set_inst_prefetch_distance 0x2
	s_xor_b32 s9, s11, -1
	v_mov_b32_e32 v2, 0
	v_mov_b32_e32 v3, 0
	s_and_b32 s10, s9, exec_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_xor_b32 s9, s10, exec_lo
	s_cmp_lg_u32 s10, 0
	s_cmov_b32 exec_lo, s10
	s_cbranch_scc0 .LBB1_7
; %bb.6:
	v_add_co_u32 v0, s2, s2, v1
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v1, null, s3, 0, s2
	v_add_co_u32 v2, vcc_lo, v0, 8
	s_delay_alu instid0(VALU_DEP_2)
	v_add_co_ci_u32_e32 v3, vcc_lo, 0, v1, vcc_lo
	s_or_b32 exec_lo, exec_lo, s9
.LBB1_7:                                ; %__printf_alloc.exit
	s_delay_alu instid0(VALU_DEP_1)
	v_cmp_ne_u64_e32 vcc_lo, 0, v[2:3]
	s_mov_b32 s2, exec_lo
	s_cmp_lg_u32 vcc_lo, 0
	s_cmov_b32 exec_lo, vcc_lo
	s_cbranch_scc0 .LBB1_9
; %bb.8:
	v_mov_b32_e32 v0, 7
	global_store_b32 v[2:3], v0, off
	s_or_b32 exec_lo, exec_lo, s2
.LBB1_9:                                ; %Flow125
	v_mov_b32_e32 v6, 0
	s_or_b32 exec_lo, exec_lo, s5
.LBB1_10:
	v_mov_b32_e32 v0, 0x9abcdef0
	v_dual_mov_b32 v1, 0x12345678 :: v_dual_mov_b32 v2, 0x12345678
	v_dual_mov_b32 v3, 0x11111111 :: v_dual_mov_b32 v4, 0x11111111
	s_getpc_b64 s[2:3]
	s_add_u32 s2, s2, uint96_add_64@rel32@lo+4
	s_addc_u32 s3, s3, uint96_add_64@rel32@hi+12
	s_delay_alu instid0(SALU_CYCLE_1)
	s_swappc_b64 s[30:31], s[2:3]
	s_mov_b32 s2, 0xabcdf001
	s_mov_b32 s3, 0x23456789
	s_mov_b32 s5, exec_lo
	v_cmp_ne_u64_e32 vcc_lo, s[2:3], v[0:1]
	v_cmp_ne_u32_e64 s2, 0x12345678, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_or_b32 s2, vcc_lo, s2
	s_and_b32 s2, s2, exec_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_cmov_b32 exec_lo, s2
	s_cbranch_scc0 .LBB1_20
; %bb.11:
	s_load_b64 s[2:3], s[6:7], 0x48
	v_mov_b32_e32 v2, 0
	s_mov_b32 s9, 0
                                        ; implicit-def: $sgpr10
                                        ; implicit-def: $sgpr12
                                        ; implicit-def: $sgpr11
	s_waitcnt lgkmcnt(0)
	s_clause 0x1
	global_load_b32 v3, v2, s[2:3] offset:4
	global_load_b32 v0, v2, s[2:3] glc
	s_set_inst_prefetch_distance 0x1
	s_branch .LBB1_13
	.p2align	6
.LBB1_12:                               ; %Flow123
                                        ;   in Loop: Header=BB1_13 Depth=1
	s_and_b32 s13, exec_lo, s12
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_or_b32 s9, s13, s9
	s_and_not1_b32 s10, s10, exec_lo
	s_and_b32 s13, s11, exec_lo
	s_or_b32 s10, s10, s13
	s_and_not1_b32 s13, exec_lo, s9
	s_delay_alu instid0(SALU_CYCLE_1)
	s_cselect_b32 exec_lo, s13, s9
	s_cbranch_scc0 .LBB1_15
.LBB1_13:                               ; =>This Inner Loop Header: Depth=1
	s_waitcnt vmcnt(0)
	v_mov_b32_e32 v1, v0
	s_or_b32 s11, s11, exec_lo
	s_or_b32 s12, s12, exec_lo
	s_mov_b32 s13, exec_lo
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v0, 12, v1
	v_cmp_le_u32_e32 vcc_lo, v0, v3
                                        ; implicit-def: $vgpr0
	s_cmp_lg_u32 vcc_lo, 0
	s_cmov_b32 exec_lo, vcc_lo
	s_cbranch_scc0 .LBB1_12
; %bb.14:                               ;   in Loop: Header=BB1_13 Depth=1
	v_add_nc_u32_e32 v0, 4, v1
	s_and_not1_b32 s12, s12, exec_lo
	s_and_not1_b32 s11, s11, exec_lo
	global_atomic_cmpswap_b32 v0, v2, v[0:1], s[2:3] glc
	s_waitcnt vmcnt(0)
	v_cmp_eq_u32_e32 vcc_lo, v0, v1
	s_and_b32 s14, vcc_lo, exec_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_or_b32 s12, s12, s14
	s_or_b32 exec_lo, exec_lo, s13
	s_branch .LBB1_12
.LBB1_15:                               ; %loop.exit.guard90
	s_set_inst_prefetch_distance 0x2
	s_xor_b32 s9, s10, -1
	v_mov_b32_e32 v2, 0
	v_mov_b32_e32 v3, 0
	s_and_b32 s10, s9, exec_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_xor_b32 s9, s10, exec_lo
	s_cmp_lg_u32 s10, 0
	s_cmov_b32 exec_lo, s10
	s_cbranch_scc0 .LBB1_17
; %bb.16:
	v_add_co_u32 v0, s2, s2, v1
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v1, null, s3, 0, s2
	v_add_co_u32 v2, vcc_lo, v0, 8
	s_delay_alu instid0(VALU_DEP_2)
	v_add_co_ci_u32_e32 v3, vcc_lo, 0, v1, vcc_lo
	s_or_b32 exec_lo, exec_lo, s9
.LBB1_17:                               ; %__printf_alloc.exit7
	s_delay_alu instid0(VALU_DEP_1)
	v_cmp_ne_u64_e32 vcc_lo, 0, v[2:3]
	s_mov_b32 s2, exec_lo
	s_cmp_lg_u32 vcc_lo, 0
	s_cmov_b32 exec_lo, vcc_lo
	s_cbranch_scc0 .LBB1_19
; %bb.18:
	v_mov_b32_e32 v0, 6
	global_store_b32 v[2:3], v0, off
	s_or_b32 exec_lo, exec_lo, s2
.LBB1_19:                               ; %Flow122
	v_mov_b32_e32 v6, 0
	s_or_b32 exec_lo, exec_lo, s5
.LBB1_20:
	v_dual_mov_b32 v7, 0 :: v_dual_mov_b32 v0, -1
	v_dual_mov_b32 v1, -1 :: v_dual_mov_b32 v2, 0x12345678
	v_dual_mov_b32 v3, 1 :: v_dual_mov_b32 v4, 0
	s_getpc_b64 s[2:3]
	s_add_u32 s2, s2, uint96_add_64@rel32@lo+4
	s_addc_u32 s3, s3, uint96_add_64@rel32@hi+12
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_3) | instid1(VALU_DEP_1)
	s_swappc_b64 s[30:31], s[2:3]
	v_cmp_ne_u64_e32 vcc_lo, 0, v[0:1]
	v_cmp_ne_u32_e64 s2, 0x12345679, v2
	s_mov_b32 s5, exec_lo
	s_or_b32 s2, vcc_lo, s2
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_and_b32 s2, s2, exec_lo
	s_cmov_b32 exec_lo, s2
	s_cbranch_scc0 .LBB1_30
; %bb.21:
	s_load_b64 s[2:3], s[6:7], 0x48
	s_mov_b32 s9, 0
                                        ; implicit-def: $sgpr10
                                        ; implicit-def: $sgpr12
                                        ; implicit-def: $sgpr11
	s_waitcnt lgkmcnt(0)
	s_clause 0x1
	global_load_b32 v2, v7, s[2:3] offset:4
	global_load_b32 v0, v7, s[2:3] glc
	s_set_inst_prefetch_distance 0x1
	s_branch .LBB1_23
	.p2align	6
.LBB1_22:                               ; %Flow120
                                        ;   in Loop: Header=BB1_23 Depth=1
	s_and_b32 s13, exec_lo, s12
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_or_b32 s9, s13, s9
	s_and_not1_b32 s10, s10, exec_lo
	s_and_b32 s13, s11, exec_lo
	s_or_b32 s10, s10, s13
	s_and_not1_b32 s13, exec_lo, s9
	s_delay_alu instid0(SALU_CYCLE_1)
	s_cselect_b32 exec_lo, s13, s9
	s_cbranch_scc0 .LBB1_25
.LBB1_23:                               ; =>This Inner Loop Header: Depth=1
	s_waitcnt vmcnt(0)
	v_mov_b32_e32 v1, v0
	s_or_b32 s11, s11, exec_lo
	s_or_b32 s12, s12, exec_lo
	s_mov_b32 s13, exec_lo
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v0, 12, v1
	v_cmp_le_u32_e32 vcc_lo, v0, v2
                                        ; implicit-def: $vgpr0
	s_cmp_lg_u32 vcc_lo, 0
	s_cmov_b32 exec_lo, vcc_lo
	s_cbranch_scc0 .LBB1_22
; %bb.24:                               ;   in Loop: Header=BB1_23 Depth=1
	v_add_nc_u32_e32 v0, 4, v1
	s_and_not1_b32 s12, s12, exec_lo
	s_and_not1_b32 s11, s11, exec_lo
	global_atomic_cmpswap_b32 v0, v7, v[0:1], s[2:3] glc
	s_waitcnt vmcnt(0)
	v_cmp_eq_u32_e32 vcc_lo, v0, v1
	s_and_b32 s14, vcc_lo, exec_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_or_b32 s12, s12, s14
	s_or_b32 exec_lo, exec_lo, s13
	s_branch .LBB1_22
.LBB1_25:                               ; %loop.exit.guard93
	s_set_inst_prefetch_distance 0x2
	s_xor_b32 s9, s10, -1
	v_mov_b32_e32 v2, 0
	v_mov_b32_e32 v3, 0
	s_and_b32 s10, s9, exec_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_xor_b32 s9, s10, exec_lo
	s_cmp_lg_u32 s10, 0
	s_cmov_b32 exec_lo, s10
	s_cbranch_scc0 .LBB1_27
; %bb.26:
	v_add_co_u32 v0, s2, s2, v1
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v1, null, s3, 0, s2
	v_add_co_u32 v2, vcc_lo, v0, 8
	s_delay_alu instid0(VALU_DEP_2)
	v_add_co_ci_u32_e32 v3, vcc_lo, 0, v1, vcc_lo
	s_or_b32 exec_lo, exec_lo, s9
.LBB1_27:                               ; %__printf_alloc.exit8
	s_delay_alu instid0(VALU_DEP_1)
	v_cmp_ne_u64_e32 vcc_lo, 0, v[2:3]
	s_mov_b32 s2, exec_lo
	s_cmp_lg_u32 vcc_lo, 0
	s_cmov_b32 exec_lo, vcc_lo
	s_cbranch_scc0 .LBB1_29
; %bb.28:
	v_mov_b32_e32 v0, 5
	global_store_b32 v[2:3], v0, off
	s_or_b32 exec_lo, exec_lo, s2
.LBB1_29:                               ; %Flow119
	v_mov_b32_e32 v6, 0
	s_or_b32 exec_lo, exec_lo, s5
.LBB1_30:
	v_dual_mov_b32 v7, 0 :: v_dual_mov_b32 v0, -2
	v_dual_mov_b32 v1, -1 :: v_dual_mov_b32 v2, 0x12345678
	v_dual_mov_b32 v3, 3 :: v_dual_mov_b32 v4, 0
	s_getpc_b64 s[2:3]
	s_add_u32 s2, s2, uint96_add_64@rel32@lo+4
	s_addc_u32 s3, s3, uint96_add_64@rel32@hi+12
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_3) | instid1(VALU_DEP_1)
	s_swappc_b64 s[30:31], s[2:3]
	v_cmp_ne_u64_e32 vcc_lo, 1, v[0:1]
	v_cmp_ne_u32_e64 s2, 0x12345679, v2
	s_mov_b32 s5, exec_lo
	s_or_b32 s2, vcc_lo, s2
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_and_b32 s2, s2, exec_lo
	s_cmov_b32 exec_lo, s2
	s_cbranch_scc0 .LBB1_40
; %bb.31:
	s_load_b64 s[2:3], s[6:7], 0x48
	s_mov_b32 s9, 0
                                        ; implicit-def: $sgpr10
                                        ; implicit-def: $sgpr12
                                        ; implicit-def: $sgpr11
	s_waitcnt lgkmcnt(0)
	s_clause 0x1
	global_load_b32 v2, v7, s[2:3] offset:4
	global_load_b32 v0, v7, s[2:3] glc
	s_set_inst_prefetch_distance 0x1
	s_branch .LBB1_33
	.p2align	6
.LBB1_32:                               ; %Flow117
                                        ;   in Loop: Header=BB1_33 Depth=1
	s_and_b32 s13, exec_lo, s12
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_or_b32 s9, s13, s9
	s_and_not1_b32 s10, s10, exec_lo
	s_and_b32 s13, s11, exec_lo
	s_or_b32 s10, s10, s13
	s_and_not1_b32 s13, exec_lo, s9
	s_delay_alu instid0(SALU_CYCLE_1)
	s_cselect_b32 exec_lo, s13, s9
	s_cbranch_scc0 .LBB1_35
.LBB1_33:                               ; =>This Inner Loop Header: Depth=1
	s_waitcnt vmcnt(0)
	v_mov_b32_e32 v1, v0
	s_or_b32 s11, s11, exec_lo
	s_or_b32 s12, s12, exec_lo
	s_mov_b32 s13, exec_lo
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v0, 12, v1
	v_cmp_le_u32_e32 vcc_lo, v0, v2
                                        ; implicit-def: $vgpr0
	s_cmp_lg_u32 vcc_lo, 0
	s_cmov_b32 exec_lo, vcc_lo
	s_cbranch_scc0 .LBB1_32
; %bb.34:                               ;   in Loop: Header=BB1_33 Depth=1
	v_add_nc_u32_e32 v0, 4, v1
	s_and_not1_b32 s12, s12, exec_lo
	s_and_not1_b32 s11, s11, exec_lo
	global_atomic_cmpswap_b32 v0, v7, v[0:1], s[2:3] glc
	s_waitcnt vmcnt(0)
	v_cmp_eq_u32_e32 vcc_lo, v0, v1
	s_and_b32 s14, vcc_lo, exec_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_or_b32 s12, s12, s14
	s_or_b32 exec_lo, exec_lo, s13
	s_branch .LBB1_32
.LBB1_35:                               ; %loop.exit.guard96
	s_set_inst_prefetch_distance 0x2
	s_xor_b32 s9, s10, -1
	v_mov_b32_e32 v2, 0
	v_mov_b32_e32 v3, 0
	s_and_b32 s10, s9, exec_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_xor_b32 s9, s10, exec_lo
	s_cmp_lg_u32 s10, 0
	s_cmov_b32 exec_lo, s10
	s_cbranch_scc0 .LBB1_37
; %bb.36:
	v_add_co_u32 v0, s2, s2, v1
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v1, null, s3, 0, s2
	v_add_co_u32 v2, vcc_lo, v0, 8
	s_delay_alu instid0(VALU_DEP_2)
	v_add_co_ci_u32_e32 v3, vcc_lo, 0, v1, vcc_lo
	s_or_b32 exec_lo, exec_lo, s9
.LBB1_37:                               ; %__printf_alloc.exit9
	s_delay_alu instid0(VALU_DEP_1)
	v_cmp_ne_u64_e32 vcc_lo, 0, v[2:3]
	s_mov_b32 s2, exec_lo
	s_cmp_lg_u32 vcc_lo, 0
	s_cmov_b32 exec_lo, vcc_lo
	s_cbranch_scc0 .LBB1_39
; %bb.38:
	v_mov_b32_e32 v0, 4
	global_store_b32 v[2:3], v0, off
	s_or_b32 exec_lo, exec_lo, s2
.LBB1_39:                               ; %Flow116
	v_mov_b32_e32 v6, 0
	s_or_b32 exec_lo, exec_lo, s5
.LBB1_40:
	v_dual_mov_b32 v7, 0 :: v_dual_mov_b32 v0, 0x9abcdef0
	v_dual_mov_b32 v1, 0x12345678 :: v_dual_mov_b32 v2, 0x12345678
	v_dual_mov_b32 v3, 0 :: v_dual_mov_b32 v4, 0
	s_getpc_b64 s[2:3]
	s_add_u32 s2, s2, uint96_add_64@rel32@lo+4
	s_addc_u32 s3, s3, uint96_add_64@rel32@hi+12
	s_delay_alu instid0(SALU_CYCLE_1)
	s_swappc_b64 s[30:31], s[2:3]
	s_mov_b32 s2, 0x9abcdef0
	s_mov_b32 s3, 0x12345678
	s_mov_b32 s5, exec_lo
	v_cmp_ne_u64_e32 vcc_lo, s[2:3], v[0:1]
	v_cmp_ne_u32_e64 s2, 0x12345678, v2
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_or_b32 s2, vcc_lo, s2
	s_and_b32 s2, s2, exec_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_cmov_b32 exec_lo, s2
	s_cbranch_scc0 .LBB1_50
; %bb.41:
	s_load_b64 s[2:3], s[6:7], 0x48
	s_mov_b32 s9, 0
                                        ; implicit-def: $sgpr10
                                        ; implicit-def: $sgpr12
                                        ; implicit-def: $sgpr11
	s_waitcnt lgkmcnt(0)
	s_clause 0x1
	global_load_b32 v2, v7, s[2:3] offset:4
	global_load_b32 v0, v7, s[2:3] glc
	s_set_inst_prefetch_distance 0x1
	s_branch .LBB1_43
	.p2align	6
.LBB1_42:                               ; %Flow114
                                        ;   in Loop: Header=BB1_43 Depth=1
	s_and_b32 s13, exec_lo, s12
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_or_b32 s9, s13, s9
	s_and_not1_b32 s10, s10, exec_lo
	s_and_b32 s13, s11, exec_lo
	s_or_b32 s10, s10, s13
	s_and_not1_b32 s13, exec_lo, s9
	s_delay_alu instid0(SALU_CYCLE_1)
	s_cselect_b32 exec_lo, s13, s9
	s_cbranch_scc0 .LBB1_45
.LBB1_43:                               ; =>This Inner Loop Header: Depth=1
	s_waitcnt vmcnt(0)
	v_mov_b32_e32 v1, v0
	s_or_b32 s11, s11, exec_lo
	s_or_b32 s12, s12, exec_lo
	s_mov_b32 s13, exec_lo
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v0, 12, v1
	v_cmp_le_u32_e32 vcc_lo, v0, v2
                                        ; implicit-def: $vgpr0
	s_cmp_lg_u32 vcc_lo, 0
	s_cmov_b32 exec_lo, vcc_lo
	s_cbranch_scc0 .LBB1_42
; %bb.44:                               ;   in Loop: Header=BB1_43 Depth=1
	v_add_nc_u32_e32 v0, 4, v1
	s_and_not1_b32 s12, s12, exec_lo
	s_and_not1_b32 s11, s11, exec_lo
	global_atomic_cmpswap_b32 v0, v7, v[0:1], s[2:3] glc
	s_waitcnt vmcnt(0)
	v_cmp_eq_u32_e32 vcc_lo, v0, v1
	s_and_b32 s14, vcc_lo, exec_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_or_b32 s12, s12, s14
	s_or_b32 exec_lo, exec_lo, s13
	s_branch .LBB1_42
.LBB1_45:                               ; %loop.exit.guard99
	s_set_inst_prefetch_distance 0x2
	s_xor_b32 s9, s10, -1
	v_mov_b32_e32 v2, 0
	v_mov_b32_e32 v3, 0
	s_and_b32 s10, s9, exec_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_xor_b32 s9, s10, exec_lo
	s_cmp_lg_u32 s10, 0
	s_cmov_b32 exec_lo, s10
	s_cbranch_scc0 .LBB1_47
; %bb.46:
	v_add_co_u32 v0, s2, s2, v1
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v1, null, s3, 0, s2
	v_add_co_u32 v2, vcc_lo, v0, 8
	s_delay_alu instid0(VALU_DEP_2)
	v_add_co_ci_u32_e32 v3, vcc_lo, 0, v1, vcc_lo
	s_or_b32 exec_lo, exec_lo, s9
.LBB1_47:                               ; %__printf_alloc.exit10
	s_delay_alu instid0(VALU_DEP_1)
	v_cmp_ne_u64_e32 vcc_lo, 0, v[2:3]
	s_mov_b32 s2, exec_lo
	s_cmp_lg_u32 vcc_lo, 0
	s_cmov_b32 exec_lo, vcc_lo
	s_cbranch_scc0 .LBB1_49
; %bb.48:
	v_mov_b32_e32 v0, 3
	global_store_b32 v[2:3], v0, off
	s_or_b32 exec_lo, exec_lo, s2
.LBB1_49:                               ; %Flow113
	v_mov_b32_e32 v6, 0
	s_or_b32 exec_lo, exec_lo, s5
.LBB1_50:
	v_dual_mov_b32 v0, -1 :: v_dual_mov_b32 v1, -1
	v_dual_mov_b32 v2, -1 :: v_dual_mov_b32 v3, -1
	v_mov_b32_e32 v4, -1
	s_getpc_b64 s[2:3]
	s_add_u32 s2, s2, uint96_add_64@rel32@lo+4
	s_addc_u32 s3, s3, uint96_add_64@rel32@hi+12
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_4) | instid1(VALU_DEP_1)
	s_swappc_b64 s[30:31], s[2:3]
	v_cmp_ne_u64_e32 vcc_lo, -2, v[0:1]
	v_cmp_ne_u32_e64 s2, 0, v2
	s_mov_b32 s5, exec_lo
	s_mov_b32 s9, 0
	s_or_b32 s2, vcc_lo, s2
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_and_b32 s2, s2, exec_lo
	s_cmov_b32 exec_lo, s2
	s_cbranch_scc0 .LBB1_60
; %bb.51:
	s_load_b64 s[2:3], s[6:7], 0x48
	v_mov_b32_e32 v2, 0
                                        ; implicit-def: $sgpr10
                                        ; implicit-def: $sgpr12
                                        ; implicit-def: $sgpr11
	s_waitcnt lgkmcnt(0)
	s_clause 0x1
	global_load_b32 v3, v2, s[2:3] offset:4
	global_load_b32 v0, v2, s[2:3] glc
	s_set_inst_prefetch_distance 0x1
	s_branch .LBB1_53
	.p2align	6
.LBB1_52:                               ; %Flow111
                                        ;   in Loop: Header=BB1_53 Depth=1
	s_and_b32 s13, exec_lo, s12
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_or_b32 s9, s13, s9
	s_and_not1_b32 s10, s10, exec_lo
	s_and_b32 s13, s11, exec_lo
	s_or_b32 s10, s10, s13
	s_and_not1_b32 s13, exec_lo, s9
	s_delay_alu instid0(SALU_CYCLE_1)
	s_cselect_b32 exec_lo, s13, s9
	s_cbranch_scc0 .LBB1_55
.LBB1_53:                               ; =>This Inner Loop Header: Depth=1
	s_waitcnt vmcnt(0)
	v_mov_b32_e32 v1, v0
	s_or_b32 s11, s11, exec_lo
	s_or_b32 s12, s12, exec_lo
	s_mov_b32 s13, exec_lo
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v0, 12, v1
	v_cmp_le_u32_e32 vcc_lo, v0, v3
                                        ; implicit-def: $vgpr0
	s_cmp_lg_u32 vcc_lo, 0
	s_cmov_b32 exec_lo, vcc_lo
	s_cbranch_scc0 .LBB1_52
; %bb.54:                               ;   in Loop: Header=BB1_53 Depth=1
	v_add_nc_u32_e32 v0, 4, v1
	s_and_not1_b32 s12, s12, exec_lo
	s_and_not1_b32 s11, s11, exec_lo
	global_atomic_cmpswap_b32 v0, v2, v[0:1], s[2:3] glc
	s_waitcnt vmcnt(0)
	v_cmp_eq_u32_e32 vcc_lo, v0, v1
	s_and_b32 s14, vcc_lo, exec_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_or_b32 s12, s12, s14
	s_or_b32 exec_lo, exec_lo, s13
	s_branch .LBB1_52
.LBB1_55:                               ; %loop.exit.guard102
	s_set_inst_prefetch_distance 0x2
	s_xor_b32 s9, s10, -1
	v_mov_b32_e32 v2, 0
	v_mov_b32_e32 v3, 0
	s_and_b32 s10, s9, exec_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_xor_b32 s9, s10, exec_lo
	s_cmp_lg_u32 s10, 0
	s_cmov_b32 exec_lo, s10
	s_cbranch_scc0 .LBB1_57
; %bb.56:
	v_add_co_u32 v0, s2, s2, v1
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v1, null, s3, 0, s2
	v_add_co_u32 v2, vcc_lo, v0, 8
	s_delay_alu instid0(VALU_DEP_2)
	v_add_co_ci_u32_e32 v3, vcc_lo, 0, v1, vcc_lo
	s_or_b32 exec_lo, exec_lo, s9
.LBB1_57:                               ; %__printf_alloc.exit11
	s_delay_alu instid0(VALU_DEP_1)
	v_cmp_ne_u64_e32 vcc_lo, 0, v[2:3]
	s_mov_b32 s2, exec_lo
	s_cmp_lg_u32 vcc_lo, 0
	s_cmov_b32 exec_lo, vcc_lo
	s_cbranch_scc0 .LBB1_59
; %bb.58:
	v_mov_b32_e32 v0, 2
	global_store_b32 v[2:3], v0, off
	s_or_b32 exec_lo, exec_lo, s2
.LBB1_59:                               ; %Flow110
	v_mov_b32_e32 v6, 0
	s_or_b32 exec_lo, exec_lo, s5
.LBB1_60:
	v_dual_mov_b32 v7, 0 :: v_dual_mov_b32 v0, -1
	v_dual_mov_b32 v1, -1 :: v_dual_mov_b32 v2, -2
	v_dual_mov_b32 v3, 1 :: v_dual_mov_b32 v4, 0
	s_getpc_b64 s[2:3]
	s_add_u32 s2, s2, uint96_add_64@rel32@lo+4
	s_addc_u32 s3, s3, uint96_add_64@rel32@hi+12
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_3) | instid1(VALU_DEP_1)
	s_swappc_b64 s[30:31], s[2:3]
	v_cmp_ne_u64_e32 vcc_lo, 0, v[0:1]
	v_cmp_ne_u32_e64 s2, -1, v2
	s_mov_b32 s5, exec_lo
	s_or_b32 s2, vcc_lo, s2
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_and_b32 s2, s2, exec_lo
	s_cmov_b32 exec_lo, s2
	s_cbranch_scc0 .LBB1_70
; %bb.61:
	s_load_b64 s[2:3], s[6:7], 0x48
	s_mov_b32 s6, 0
                                        ; implicit-def: $sgpr7
                                        ; implicit-def: $sgpr10
                                        ; implicit-def: $sgpr9
	s_waitcnt lgkmcnt(0)
	s_clause 0x1
	global_load_b32 v2, v7, s[2:3] offset:4
	global_load_b32 v0, v7, s[2:3] glc
	s_set_inst_prefetch_distance 0x1
	s_branch .LBB1_63
	.p2align	6
.LBB1_62:                               ; %Flow108
                                        ;   in Loop: Header=BB1_63 Depth=1
	s_and_b32 s11, exec_lo, s10
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_2) | instid1(SALU_CYCLE_1)
	s_or_b32 s6, s11, s6
	s_and_not1_b32 s7, s7, exec_lo
	s_and_b32 s11, s9, exec_lo
	s_or_b32 s7, s7, s11
	s_and_not1_b32 s11, exec_lo, s6
	s_delay_alu instid0(SALU_CYCLE_1)
	s_cselect_b32 exec_lo, s11, s6
	s_cbranch_scc0 .LBB1_65
.LBB1_63:                               ; =>This Inner Loop Header: Depth=1
	s_waitcnt vmcnt(0)
	v_mov_b32_e32 v1, v0
	s_or_b32 s9, s9, exec_lo
	s_or_b32 s10, s10, exec_lo
	s_mov_b32 s11, exec_lo
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_1)
	v_add_nc_u32_e32 v0, 12, v1
	v_cmp_le_u32_e32 vcc_lo, v0, v2
                                        ; implicit-def: $vgpr0
	s_cmp_lg_u32 vcc_lo, 0
	s_cmov_b32 exec_lo, vcc_lo
	s_cbranch_scc0 .LBB1_62
; %bb.64:                               ;   in Loop: Header=BB1_63 Depth=1
	v_add_nc_u32_e32 v0, 4, v1
	s_and_not1_b32 s10, s10, exec_lo
	s_and_not1_b32 s9, s9, exec_lo
	global_atomic_cmpswap_b32 v0, v7, v[0:1], s[2:3] glc
	s_waitcnt vmcnt(0)
	v_cmp_eq_u32_e32 vcc_lo, v0, v1
	s_and_b32 s12, vcc_lo, exec_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_or_b32 s10, s10, s12
	s_or_b32 exec_lo, exec_lo, s11
	s_branch .LBB1_62
.LBB1_65:                               ; %loop.exit.guard105
	s_set_inst_prefetch_distance 0x2
	s_xor_b32 s6, s7, -1
	v_mov_b32_e32 v2, 0
	v_mov_b32_e32 v3, 0
	s_and_b32 s7, s6, exec_lo
	s_delay_alu instid0(SALU_CYCLE_1)
	s_xor_b32 s6, s7, exec_lo
	s_cmp_lg_u32 s7, 0
	s_cmov_b32 exec_lo, s7
	s_cbranch_scc0 .LBB1_67
; %bb.66:
	v_add_co_u32 v0, s2, s2, v1
	s_delay_alu instid0(VALU_DEP_1) | instskip(NEXT) | instid1(VALU_DEP_2)
	v_add_co_ci_u32_e64 v1, null, s3, 0, s2
	v_add_co_u32 v2, vcc_lo, v0, 8
	s_delay_alu instid0(VALU_DEP_2)
	v_add_co_ci_u32_e32 v3, vcc_lo, 0, v1, vcc_lo
	s_or_b32 exec_lo, exec_lo, s6
.LBB1_67:                               ; %__printf_alloc.exit12
	s_delay_alu instid0(VALU_DEP_1)
	v_cmp_ne_u64_e32 vcc_lo, 0, v[2:3]
	s_mov_b32 s2, exec_lo
	s_cmp_lg_u32 vcc_lo, 0
	s_cmov_b32 exec_lo, vcc_lo
	s_cbranch_scc0 .LBB1_69
; %bb.68:
	v_mov_b32_e32 v0, 1
	global_store_b32 v[2:3], v0, off
	s_or_b32 exec_lo, exec_lo, s2
.LBB1_69:                               ; %Flow
	v_mov_b32_e32 v6, 0
	s_or_b32 exec_lo, exec_lo, s5
.LBB1_70:
	s_load_b64 s[0:1], s[0:1], 0x0
	s_and_b32 s2, 0xffff, s8
	s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
	s_mul_i32 s15, s15, s2
	v_add3_u32 v0, s4, s15, v5
	s_delay_alu instid0(VALU_DEP_1) | instskip(SKIP_2) | instid1(VALU_DEP_2)
	v_ashrrev_i32_e32 v1, 31, v0
	s_waitcnt lgkmcnt(0)
	v_add_co_u32 v0, vcc_lo, s0, v0
	v_add_co_ci_u32_e32 v1, vcc_lo, s1, v1, vcc_lo
	global_store_b8 v[0:1], v6, off
	s_endpgm
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel test_uint96_add_64
		.amdhsa_group_segment_fixed_size 0
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 264
		.amdhsa_user_sgpr_count 15
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_wavefront_size32 1
		.amdhsa_uses_dynamic_stack 0
		.amdhsa_enable_private_segment 0
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 0
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 0
		.amdhsa_next_free_vgpr 8
		.amdhsa_next_free_sgpr 33
		.amdhsa_float_round_mode_32 0
		.amdhsa_float_round_mode_16_64 0
		.amdhsa_float_denorm_mode_32 3
		.amdhsa_float_denorm_mode_16_64 3
		.amdhsa_dx10_clamp 1
		.amdhsa_ieee_mode 1
		.amdhsa_fp16_overflow 0
		.amdhsa_workgroup_processor_mode 1
		.amdhsa_memory_ordered 1
		.amdhsa_forward_progress 0
		.amdhsa_shared_vgpr_count 0
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.text
.Lfunc_end1:
	.size	test_uint96_add_64, .Lfunc_end1-test_uint96_add_64
                                        ; -- End function
	.section	.AMDGPU.csdata,"",@progbits
; Kernel info:
; codeLenInByte = 2936
; NumSgprs: 35
; NumVgprs: 8
; ScratchSize: 0
; MemoryBound: 0
; FloatMode: 240
; IeeeMode: 1
; LDSByteSize: 0 bytes/workgroup (compile time only)
; SGPRBlocks: 4
; VGPRBlocks: 0
; NumSGPRsForWavesPerEU: 35
; NumVGPRsForWavesPerEU: 8
; Occupancy: 16
; WaveLimiterHint : 0
; COMPUTE_PGM_RSRC2:SCRATCH_EN: 0
; COMPUTE_PGM_RSRC2:USER_SGPR: 15
; COMPUTE_PGM_RSRC2:TRAP_HANDLER: 0
; COMPUTE_PGM_RSRC2:TGID_X_EN: 1
; COMPUTE_PGM_RSRC2:TGID_Y_EN: 0
; COMPUTE_PGM_RSRC2:TGID_Z_EN: 0
; COMPUTE_PGM_RSRC2:TIDIG_COMP_CNT: 0
	.text
	.p2alignl 7, 3214868480
	.fill 96, 4, 3214868480
	.ident	"AMD clang version 18.0.0git (https://github.com/RadeonOpenCompute/llvm-project roc-6.2.3 24355 77cf9ad00e298ed06e06aec0f81009510f545714)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.amdgpu_metadata
---
amdhsa.kernels:
  - .args:
      - .address_space:  global
        .name:           results
        .offset:         0
        .size:           8
        .type_name:      'char*'
        .value_kind:     global_buffer
      - .offset:         8
        .size:           4
        .value_kind:     hidden_block_count_x
      - .offset:         12
        .size:           4
        .value_kind:     hidden_block_count_y
      - .offset:         16
        .size:           4
        .value_kind:     hidden_block_count_z
      - .offset:         20
        .size:           2
        .value_kind:     hidden_group_size_x
      - .offset:         22
        .size:           2
        .value_kind:     hidden_group_size_y
      - .offset:         24
        .size:           2
        .value_kind:     hidden_group_size_z
      - .offset:         26
        .size:           2
        .value_kind:     hidden_remainder_x
      - .offset:         28
        .size:           2
        .value_kind:     hidden_remainder_y
      - .offset:         30
        .size:           2
        .value_kind:     hidden_remainder_z
      - .offset:         48
        .size:           8
        .value_kind:     hidden_global_offset_x
      - .offset:         56
        .size:           8
        .value_kind:     hidden_global_offset_y
      - .offset:         64
        .size:           8
        .value_kind:     hidden_global_offset_z
      - .offset:         72
        .size:           2
        .value_kind:     hidden_grid_dims
      - .offset:         80
        .size:           8
        .value_kind:     hidden_printf_buffer
    .group_segment_fixed_size: 0
    .kernarg_segment_align: 8
    .kernarg_segment_size: 264
    .language:       OpenCL C
    .language_version:
      - 1
      - 2
    .max_flat_workgroup_size: 256
    .name:           test_uint96_add_64
    .private_segment_fixed_size: 0
    .sgpr_count:     35
    .sgpr_spill_count: 0
    .symbol:         test_uint96_add_64.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     8
    .vgpr_spill_count: 0
    .wavefront_size: 32
    .workgroup_processor_mode: 1
amdhsa.printf:
  - '1:0:test 7 failed\n'
  - '2:0:test 6 failed\n'
  - '3:0:test 5 failed\n'
  - '4:0:test 4 failed\n'
  - '5:0:test 3 failed\n'
  - '6:0:test 2 failed\n'
  - '7:0:test 1 failed\n'
amdhsa.target:   amdgcn-amd-amdhsa--gfx1100
amdhsa.version:
  - 1
  - 2
...

	.end_amdgpu_metadata
