%def invoke(helper="UndefinedInvokeHandler"):
/*
 * Generic invoke handler wrapper.
 */
    /* op vB, {vD, vE, vF, vG, vA}, class@CCCC */
    /* op {vCCCC..v(CCCC+AA-1)}, meth@BBBB */
    .extern $helper
    EXPORT_PC
    movq    rSELF, OUT_ARG0
    leaq    OFF_FP_SHADOWFRAME(rFP), OUT_ARG1
    movq    rPC, OUT_ARG2
    REFRESH_INST ${opnum}
    movl    rINST, OUT_32_ARG3
    call    SYMBOL($helper)
    testb   %al, %al
    jz      MterpException
    ADVANCE_PC 3
    movq    rSELF, %rax
    cmpb    LITERAL(0), THREAD_USE_MTERP_OFFSET(%rax)
    jz      MterpFallback
    FETCH_INST
    GOTO_NEXT

%def invoke_polymorphic(helper="UndefinedInvokeHandler"):
    /*
     * invoke-polymorphic handler wrapper.
     */
    /* op {vC, vD, vE, vF, vG}, meth@BBBB, proto@HHHH */
    /* op {vCCCC..v(CCCC+AA-1)}, meth@BBBB, proto@HHHH */
    .extern $helper
    EXPORT_PC
    movq    rSELF, OUT_ARG0
    leaq    OFF_FP_SHADOWFRAME(rFP), OUT_ARG1
    movq    rPC, OUT_ARG2
    REFRESH_INST ${opnum}
    movl    rINST, OUT_32_ARG3
    call    SYMBOL($helper)
    testb   %al, %al
    jz      MterpException
    ADVANCE_PC 4
    movq    rSELF, %rax
    cmpb    LITERAL(0), THREAD_USE_MTERP_OFFSET(%rax)
    jz      MterpFallback
    FETCH_INST
    GOTO_NEXT

%def op_invoke_custom():
%  invoke(helper="MterpInvokeCustom")

%def op_invoke_custom_range():
%  invoke(helper="MterpInvokeCustomRange")

%def op_invoke_direct():
%  invoke(helper="MterpInvokeDirect")

%def op_invoke_direct_range():
%  invoke(helper="MterpInvokeDirectRange")

%def op_invoke_interface():
%  invoke(helper="MterpInvokeInterface")
/*
 * Handle an interface method call.
 *
 * for: invoke-interface, invoke-interface/range
 */
    /* op vB, {vD, vE, vF, vG, vA}, class@CCCC */
    /* op {vCCCC..v(CCCC+AA-1)}, meth@BBBB */

%def op_invoke_interface_range():
%  invoke(helper="MterpInvokeInterfaceRange")

%def op_invoke_polymorphic():
%  invoke_polymorphic(helper="MterpInvokePolymorphic")

%def op_invoke_polymorphic_range():
%  invoke_polymorphic(helper="MterpInvokePolymorphicRange")

%def op_invoke_static():
%  invoke(helper="MterpInvokeStatic")


%def op_invoke_static_range():
%  invoke(helper="MterpInvokeStaticRange")

%def op_invoke_super():
%  invoke(helper="MterpInvokeSuper")
/*
 * Handle a "super" method call.
 *
 * for: invoke-super, invoke-super/range
 */
    /* op vB, {vD, vE, vF, vG, vA}, class@CCCC */
    /* op vAA, {vCCCC..v(CCCC+AA-1)}, meth@BBBB */

%def op_invoke_super_range():
%  invoke(helper="MterpInvokeSuperRange")

%def op_invoke_virtual():
%  invoke(helper="MterpInvokeVirtual")
/*
 * Handle a virtual method call.
 *
 * for: invoke-virtual, invoke-virtual/range
 */
    /* op vB, {vD, vE, vF, vG, vA}, class@CCCC */
    /* op vAA, {vCCCC..v(CCCC+AA-1)}, meth@BBBB */

%def op_invoke_virtual_range():
%  invoke(helper="MterpInvokeVirtualRange")
