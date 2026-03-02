# R8/D8 "no second switch" pattern matching real-world bytecode from R8 optimizer.
# Based on actual bytecode from Tumblr APK (sn0/a class compiled by R8).
# Key: result variable is initialized, modified in cases, and used after switch.
.class public Lswitches/TestSwitchOverStrings5;
.super Ljava/lang/Object;

.method public test(Ljava/lang/String;)I
    .registers 4

    # v0 = result, initialized from parameter (prevents ternary collapse)
    const/4 v0, -0x1

    # v1 = str.hashCode()
    invoke-virtual {p1}, Ljava/lang/String;->hashCode()I
    move-result v1

    sparse-switch v1, :sswitch_data

    # default: fall through to after_switch
    goto :after_switch

    :case_a
    const-string v1, "a"
    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :code_a
    goto :after_switch
    :code_a
    const/4 v0, 0x1
    goto :after_switch

    :case_b
    const-string v1, "b"
    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :code_b
    goto :after_switch
    :code_b
    const/4 v0, 0x2
    goto :after_switch

    :case_c
    const-string v1, "c"
    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :code_c
    goto :after_switch
    :code_c
    const/4 v0, 0x3
    goto :after_switch

    :after_switch
    # Use result after the switch (prevents inlining into each case)
    invoke-virtual {p0, v0}, Lswitches/TestSwitchOverStrings5;->useValue(I)V
    return v0

    :sswitch_data
    .sparse-switch
        0x61 -> :case_a
        0x62 -> :case_b
        0x63 -> :case_c
    .end sparse-switch
.end method

.method public useValue(I)V
    .registers 2
    return-void
.end method
