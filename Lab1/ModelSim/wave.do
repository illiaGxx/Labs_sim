onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /PROCESSING_UNIT_tb/u_PROCESSING_UNIT/i_CLK
add wave -noupdate /PROCESSING_UNIT_tb/u_PROCESSING_UNIT/i_RST_N
add wave -noupdate /PROCESSING_UNIT_tb/u_PROCESSING_UNIT/i_CLK_EN
add wave -noupdate /PROCESSING_UNIT_tb/u_PROCESSING_UNIT/i_W0
add wave -noupdate /PROCESSING_UNIT_tb/u_PROCESSING_UNIT/i_X0
add wave -noupdate /PROCESSING_UNIT_tb/u_PROCESSING_UNIT/i_W1
add wave -noupdate /PROCESSING_UNIT_tb/u_PROCESSING_UNIT/i_X1
add wave -noupdate /PROCESSING_UNIT_tb/u_PROCESSING_UNIT/i_W2
add wave -noupdate /PROCESSING_UNIT_tb/u_PROCESSING_UNIT/i_X2
add wave -noupdate /PROCESSING_UNIT_tb/u_PROCESSING_UNIT/i_W3
add wave -noupdate /PROCESSING_UNIT_tb/u_PROCESSING_UNIT/i_X3
add wave -noupdate /PROCESSING_UNIT_tb/u_PROCESSING_UNIT/ce_out
add wave -noupdate /PROCESSING_UNIT_tb/u_PROCESSING_UNIT/o_Y
add wave -noupdate /PROCESSING_UNIT_tb/o_Y_ref
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 319
configure wave -valuecolwidth 169
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {1543 ns} {1713 ns}
