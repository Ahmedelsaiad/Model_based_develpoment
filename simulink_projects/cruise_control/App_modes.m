classdef (Enumeration) App_modes < Simulink.IntEnumType
    enumeration
        Car_stoped(0)
        cruise_on(2)
        cruise_off(1)
        cruise_off2(1)
        cruise_fault(3)
        cruise_fault2(0)
        Accelerate(3)
        break_stop(1)
        No_thing(2)
    end
end