(define (problem schedule-50-0)
(:domain schedule)
(:objects
    D2
    C2
    B2
    A2
    Z1
    W1
    V1
    U1
    S1
    R1
    P1
    Q1
    O1
    N1
    M1
    L1
    K1
    J1
    I1
    H1
    G1
    F1
    E1
    D1
    C1
    B1
    A1
    Z0
    W0
    V0
    U0
    S0
    R0
    P0
    Q0
    O0
    N0
    M0
    L0
    K0
    J0
    I0
    H0
    G0
    F0
    E0
    D0
    C0
    B0
    A0
 - part
    CIRCULAR
    OBLONG
 - ashape
    BLUE
    YELLOW
    RED
    BLACK
 - colour
    TWO
    THREE
    ONE
 - width
    BACK
    FRONT
 - anorient
)
(:init
    (SHAPE A0 CYLINDRICAL)
    (SURFACE-CONDITION A0 ROUGH)
    (PAINTED A0 YELLOW)
    (HAS-HOLE A0 THREE FRONT)
    (TEMPERATURE A0 COLD)
    (SHAPE B0 CIRCULAR)
    (SURFACE-CONDITION B0 ROUGH)
    (PAINTED B0 YELLOW)
    (HAS-HOLE B0 ONE FRONT)
    (TEMPERATURE B0 COLD)
    (SHAPE C0 CIRCULAR)
    (SURFACE-CONDITION C0 POLISHED)
    (PAINTED C0 BLUE)
    (HAS-HOLE C0 THREE FRONT)
    (TEMPERATURE C0 COLD)
    (SHAPE D0 CIRCULAR)
    (SURFACE-CONDITION D0 SMOOTH)
    (PAINTED D0 RED)
    (HAS-HOLE D0 ONE FRONT)
    (TEMPERATURE D0 COLD)
    (SHAPE E0 CYLINDRICAL)
    (SURFACE-CONDITION E0 POLISHED)
    (PAINTED E0 BLACK)
    (HAS-HOLE E0 THREE BACK)
    (TEMPERATURE E0 COLD)
    (SHAPE F0 CYLINDRICAL)
    (SURFACE-CONDITION F0 POLISHED)
    (PAINTED F0 RED)
    (HAS-HOLE F0 ONE FRONT)
    (TEMPERATURE F0 COLD)
    (SHAPE G0 CIRCULAR)
    (SURFACE-CONDITION G0 SMOOTH)
    (PAINTED G0 BLUE)
    (HAS-HOLE G0 THREE FRONT)
    (TEMPERATURE G0 COLD)
    (SHAPE H0 OBLONG)
    (SURFACE-CONDITION H0 SMOOTH)
    (PAINTED H0 RED)
    (HAS-HOLE H0 TWO BACK)
    (TEMPERATURE H0 COLD)
    (SHAPE I0 CYLINDRICAL)
    (SURFACE-CONDITION I0 ROUGH)
    (PAINTED I0 BLACK)
    (HAS-HOLE I0 THREE FRONT)
    (TEMPERATURE I0 COLD)
    (SHAPE J0 CYLINDRICAL)
    (SURFACE-CONDITION J0 ROUGH)
    (PAINTED J0 BLACK)
    (HAS-HOLE J0 ONE BACK)
    (TEMPERATURE J0 COLD)
    (SHAPE K0 CIRCULAR)
    (SURFACE-CONDITION K0 ROUGH)
    (PAINTED K0 YELLOW)
    (HAS-HOLE K0 TWO FRONT)
    (TEMPERATURE K0 COLD)
    (SHAPE L0 OBLONG)
    (SURFACE-CONDITION L0 SMOOTH)
    (PAINTED L0 BLUE)
    (HAS-HOLE L0 ONE FRONT)
    (TEMPERATURE L0 COLD)
    (SHAPE M0 OBLONG)
    (SURFACE-CONDITION M0 SMOOTH)
    (PAINTED M0 YELLOW)
    (HAS-HOLE M0 TWO FRONT)
    (TEMPERATURE M0 COLD)
    (SHAPE N0 CIRCULAR)
    (SURFACE-CONDITION N0 POLISHED)
    (PAINTED N0 BLACK)
    (HAS-HOLE N0 THREE FRONT)
    (TEMPERATURE N0 COLD)
    (SHAPE O0 CYLINDRICAL)
    (SURFACE-CONDITION O0 SMOOTH)
    (PAINTED O0 RED)
    (HAS-HOLE O0 TWO BACK)
    (TEMPERATURE O0 COLD)
    (SHAPE Q0 OBLONG)
    (SURFACE-CONDITION Q0 POLISHED)
    (PAINTED Q0 BLACK)
    (HAS-HOLE Q0 ONE FRONT)
    (TEMPERATURE Q0 COLD)
    (SHAPE P0 CIRCULAR)
    (SURFACE-CONDITION P0 ROUGH)
    (PAINTED P0 BLUE)
    (HAS-HOLE P0 TWO BACK)
    (TEMPERATURE P0 COLD)
    (SHAPE R0 OBLONG)
    (SURFACE-CONDITION R0 SMOOTH)
    (PAINTED R0 BLACK)
    (HAS-HOLE R0 THREE FRONT)
    (TEMPERATURE R0 COLD)
    (SHAPE S0 OBLONG)
    (SURFACE-CONDITION S0 ROUGH)
    (PAINTED S0 BLACK)
    (HAS-HOLE S0 THREE FRONT)
    (TEMPERATURE S0 COLD)
    (SHAPE U0 OBLONG)
    (SURFACE-CONDITION U0 SMOOTH)
    (PAINTED U0 BLACK)
    (HAS-HOLE U0 THREE BACK)
    (TEMPERATURE U0 COLD)
    (SHAPE V0 CYLINDRICAL)
    (SURFACE-CONDITION V0 ROUGH)
    (PAINTED V0 RED)
    (HAS-HOLE V0 THREE BACK)
    (TEMPERATURE V0 COLD)
    (SHAPE W0 OBLONG)
    (SURFACE-CONDITION W0 POLISHED)
    (PAINTED W0 BLACK)
    (HAS-HOLE W0 ONE BACK)
    (TEMPERATURE W0 COLD)
    (SHAPE Z0 CYLINDRICAL)
    (SURFACE-CONDITION Z0 POLISHED)
    (PAINTED Z0 YELLOW)
    (HAS-HOLE Z0 THREE FRONT)
    (TEMPERATURE Z0 COLD)
    (SHAPE A1 CYLINDRICAL)
    (SURFACE-CONDITION A1 SMOOTH)
    (PAINTED A1 YELLOW)
    (HAS-HOLE A1 ONE BACK)
    (TEMPERATURE A1 COLD)
    (SHAPE B1 CIRCULAR)
    (SURFACE-CONDITION B1 SMOOTH)
    (PAINTED B1 RED)
    (HAS-HOLE B1 ONE BACK)
    (TEMPERATURE B1 COLD)
    (SHAPE C1 OBLONG)
    (SURFACE-CONDITION C1 ROUGH)
    (PAINTED C1 RED)
    (HAS-HOLE C1 THREE FRONT)
    (TEMPERATURE C1 COLD)
    (SHAPE D1 CIRCULAR)
    (SURFACE-CONDITION D1 ROUGH)
    (PAINTED D1 BLUE)
    (HAS-HOLE D1 TWO FRONT)
    (TEMPERATURE D1 COLD)
    (SHAPE E1 CYLINDRICAL)
    (SURFACE-CONDITION E1 ROUGH)
    (PAINTED E1 BLACK)
    (HAS-HOLE E1 TWO FRONT)
    (TEMPERATURE E1 COLD)
    (SHAPE F1 CYLINDRICAL)
    (SURFACE-CONDITION F1 POLISHED)
    (PAINTED F1 YELLOW)
    (HAS-HOLE F1 ONE BACK)
    (TEMPERATURE F1 COLD)
    (SHAPE G1 OBLONG)
    (SURFACE-CONDITION G1 ROUGH)
    (PAINTED G1 YELLOW)
    (HAS-HOLE G1 TWO BACK)
    (TEMPERATURE G1 COLD)
    (SHAPE H1 OBLONG)
    (SURFACE-CONDITION H1 POLISHED)
    (PAINTED H1 RED)
    (HAS-HOLE H1 ONE BACK)
    (TEMPERATURE H1 COLD)
    (SHAPE I1 CYLINDRICAL)
    (SURFACE-CONDITION I1 ROUGH)
    (PAINTED I1 YELLOW)
    (HAS-HOLE I1 TWO BACK)
    (TEMPERATURE I1 COLD)
    (SHAPE J1 OBLONG)
    (SURFACE-CONDITION J1 SMOOTH)
    (PAINTED J1 BLUE)
    (HAS-HOLE J1 TWO BACK)
    (TEMPERATURE J1 COLD)
    (SHAPE K1 CIRCULAR)
    (SURFACE-CONDITION K1 POLISHED)
    (PAINTED K1 RED)
    (HAS-HOLE K1 THREE BACK)
    (TEMPERATURE K1 COLD)
    (SHAPE L1 CIRCULAR)
    (SURFACE-CONDITION L1 SMOOTH)
    (PAINTED L1 YELLOW)
    (HAS-HOLE L1 TWO FRONT)
    (TEMPERATURE L1 COLD)
    (SHAPE M1 CIRCULAR)
    (SURFACE-CONDITION M1 ROUGH)
    (PAINTED M1 BLACK)
    (HAS-HOLE M1 TWO FRONT)
    (TEMPERATURE M1 COLD)
    (SHAPE N1 CIRCULAR)
    (SURFACE-CONDITION N1 ROUGH)
    (PAINTED N1 BLUE)
    (HAS-HOLE N1 ONE FRONT)
    (TEMPERATURE N1 COLD)
    (SHAPE O1 OBLONG)
    (SURFACE-CONDITION O1 SMOOTH)
    (PAINTED O1 YELLOW)
    (HAS-HOLE O1 THREE BACK)
    (TEMPERATURE O1 COLD)
    (SHAPE Q1 OBLONG)
    (SURFACE-CONDITION Q1 POLISHED)
    (PAINTED Q1 YELLOW)
    (HAS-HOLE Q1 THREE FRONT)
    (TEMPERATURE Q1 COLD)
    (SHAPE P1 OBLONG)
    (SURFACE-CONDITION P1 ROUGH)
    (PAINTED P1 BLACK)
    (HAS-HOLE P1 THREE BACK)
    (TEMPERATURE P1 COLD)
    (SHAPE R1 CIRCULAR)
    (SURFACE-CONDITION R1 POLISHED)
    (PAINTED R1 YELLOW)
    (HAS-HOLE R1 ONE FRONT)
    (TEMPERATURE R1 COLD)
    (SHAPE S1 CYLINDRICAL)
    (SURFACE-CONDITION S1 SMOOTH)
    (PAINTED S1 RED)
    (HAS-HOLE S1 TWO FRONT)
    (TEMPERATURE S1 COLD)
    (SHAPE U1 OBLONG)
    (SURFACE-CONDITION U1 SMOOTH)
    (PAINTED U1 BLUE)
    (HAS-HOLE U1 ONE BACK)
    (TEMPERATURE U1 COLD)
    (SHAPE V1 OBLONG)
    (SURFACE-CONDITION V1 ROUGH)
    (PAINTED V1 YELLOW)
    (HAS-HOLE V1 ONE FRONT)
    (TEMPERATURE V1 COLD)
    (SHAPE W1 CYLINDRICAL)
    (SURFACE-CONDITION W1 POLISHED)
    (PAINTED W1 RED)
    (HAS-HOLE W1 THREE FRONT)
    (TEMPERATURE W1 COLD)
    (SHAPE Z1 CIRCULAR)
    (SURFACE-CONDITION Z1 ROUGH)
    (PAINTED Z1 RED)
    (HAS-HOLE Z1 THREE BACK)
    (TEMPERATURE Z1 COLD)
    (SHAPE A2 CYLINDRICAL)
    (SURFACE-CONDITION A2 POLISHED)
    (PAINTED A2 BLACK)
    (HAS-HOLE A2 TWO BACK)
    (TEMPERATURE A2 COLD)
    (SHAPE B2 CIRCULAR)
    (SURFACE-CONDITION B2 SMOOTH)
    (PAINTED B2 BLUE)
    (HAS-HOLE B2 THREE FRONT)
    (TEMPERATURE B2 COLD)
    (SHAPE C2 CYLINDRICAL)
    (SURFACE-CONDITION C2 ROUGH)
    (PAINTED C2 BLUE)
    (HAS-HOLE C2 THREE BACK)
    (TEMPERATURE C2 COLD)
    (SHAPE D2 OBLONG)
    (SURFACE-CONDITION D2 POLISHED)
    (PAINTED D2 BLACK)
    (HAS-HOLE D2 ONE BACK)
    (TEMPERATURE D2 COLD)
    (CAN-ORIENT DRILL-PRESS BACK)
    (CAN-ORIENT PUNCH BACK)
    (CAN-ORIENT DRILL-PRESS FRONT)
    (CAN-ORIENT PUNCH FRONT)
    (HAS-PAINT IMMERSION-PAINTER YELLOW)
    (HAS-PAINT SPRAY-PAINTER YELLOW)
    (HAS-PAINT IMMERSION-PAINTER BLUE)
    (HAS-PAINT SPRAY-PAINTER BLUE)
    (HAS-PAINT IMMERSION-PAINTER BLACK)
    (HAS-PAINT SPRAY-PAINTER BLACK)
    (HAS-PAINT IMMERSION-PAINTER RED)
    (HAS-PAINT SPRAY-PAINTER RED)
    (HAS-BIT DRILL-PRESS THREE)
    (HAS-BIT PUNCH THREE)
    (HAS-BIT DRILL-PRESS TWO)
    (HAS-BIT PUNCH TWO)
    (HAS-BIT DRILL-PRESS ONE)
    (HAS-BIT PUNCH ONE)
)
(:goal (and
    (SHAPE N1 CYLINDRICAL)
    (PAINTED G0 YELLOW)
    (PAINTED K1 BLACK)
    (SURFACE-CONDITION D0 ROUGH)
    (SURFACE-CONDITION I0 POLISHED)
    (SURFACE-CONDITION V1 POLISHED)
    (PAINTED D1 RED)
    (PAINTED Q0 RED)
    (SURFACE-CONDITION L0 POLISHED)
    (PAINTED A1 BLACK)
    (SHAPE C0 CYLINDRICAL)
    (SHAPE D0 CYLINDRICAL)
    (PAINTED V0 BLACK)
    (SHAPE N0 CYLINDRICAL)
    (PAINTED M0 BLUE)
    (SHAPE M0 CYLINDRICAL)
    (SURFACE-CONDITION D1 POLISHED)
    (PAINTED E1 BLUE)
    (SURFACE-CONDITION H0 POLISHED)
    (SURFACE-CONDITION M1 SMOOTH)
    (SURFACE-CONDITION W0 SMOOTH)
    (PAINTED I1 BLACK)
    (SHAPE K0 CYLINDRICAL)
    (SURFACE-CONDITION G1 POLISHED)
    (SURFACE-CONDITION P0 SMOOTH)
    (SURFACE-CONDITION Q0 ROUGH)
    (SHAPE B1 CYLINDRICAL)
    (PAINTED R0 YELLOW)
    (SURFACE-CONDITION E1 SMOOTH)
    (PAINTED O0 YELLOW)
    (SHAPE P1 CYLINDRICAL)
    (SURFACE-CONDITION P1 POLISHED)
    (PAINTED B1 BLACK)
    (SURFACE-CONDITION B1 ROUGH)
    (PAINTED F1 RED)
    (SURFACE-CONDITION K1 SMOOTH)
    (PAINTED S1 BLACK)
    (SURFACE-CONDITION C0 ROUGH)
    (SHAPE L0 CYLINDRICAL)
    (PAINTED C1 BLUE)
    (SURFACE-CONDITION C2 SMOOTH)
    (SHAPE U1 CYLINDRICAL)
    (SURFACE-CONDITION A1 POLISHED)
    (PAINTED D2 BLUE)
    (SHAPE H0 CYLINDRICAL)
    (SURFACE-CONDITION Q1 SMOOTH)
    (SHAPE G0 CYLINDRICAL)
    (SURFACE-CONDITION N1 POLISHED)
    (SHAPE J1 CYLINDRICAL)
    (SURFACE-CONDITION O0 ROUGH)
)))
