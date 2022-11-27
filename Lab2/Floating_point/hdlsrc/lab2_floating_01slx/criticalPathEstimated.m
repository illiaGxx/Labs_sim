open_system('gm_lab2_floating_01slx');
cs.HiliteType = 'user1';
cs.ForegroundColor = 'black';
cs.BackgroundColor = 'blue';
set_param(0, 'HiliteAncestorsData', cs);
hilite_system('gm_lab2_floating_01slx/CALC_MAGNITUDE_AND_PHASE_FLOATING_POINT/Atan2', 'user1');
annotate_port('gm_lab2_floating_01slx/CALC_MAGNITUDE_AND_PHASE_FLOATING_POINT/Atan2', 0, 1, 'cp : 7.861 ns');
