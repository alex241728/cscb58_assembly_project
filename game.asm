######################################################################
# CSCB58 Winter 2024 Assembly Final Project
# University of Toronto, Scarborough
#
# Student: Wentao Yang, 1008837902, yangwe96, alexwentao.yang@mail.utoronto.ca
# 
# Bitmap Display Configuration:
# - Unit width in pixels: 4
# - Unit height in pixels: 4
# - Display width in pixels: 256
# - Display height in pixels: 256 
# - Base Address for Display: 0x10008000 ($gp)
#
# Which milestoneshave been reached in this submission?
# (See the assignment handout for descriptions of the milestones)
# - Milestone 4
#
# Which approved features have been implemented for milestone 4?
# (See the assignment handout for the list of additional features) # 
# 1. moving platforms
# 2. different levels
# 3. pick-up effects
# 4. double jump
# 5. start menu
#
# Link to video demonstration for final submission:
# Either of the link is ok.
# - https://play.library.utoronto.ca/watch/ca5effae356d9547f871f351fa4d74c1
# - https://drive.google.com/file/d/1_wyL_gcyvTN18G6mZ1nUvJa6G-p82HXD/view?usp=drive_link
#
# Are you OK with us sharing the video with people outside course staff?
# - yes https://github.com/alex241728/cscb58_assembly_project
#
# Any additional information that the TA needs to know:
# - no
# #####################################################################

# screen
.eqv BASE_ADDRESS 0x10008000
.eqv SCREEN_WIDTH 64

# tick
.eqv SLEEP 60

# color
.eqv COLOR_RED 0xff0000
.eqv COLOR_WHITE 0xffffff
.eqv COLOR_BLACK 0x000000
.eqv COLOR_BROWN 0x9c5a3c
.eqv COLOR_CREAM 0xfff9bd
.eqv COLOR_GREEN 0xa8e61d
.eqv COLOR_BLUE 0x00b7ef
.eqv COLOR_LIGHT_BROWN 0xe5aa7a
.eqv COLOR_LIGHT_YELLOW 0xf5e49c
.eqv COLOR_PURPLE 0x6f3198
.eqv COLOR_ORANGE 0xff7e00

# keyboard inputs
.eqv KEY_W 119
.eqv KEY_A 97
.eqv KEY_S 115
.eqv KEY_D 100
.eqv KEY_P 112
.eqv KEY_R 114
.eqv KEY_Q 113

# win screen start
# x is always 0
.eqv WIN_SCREEN_START_Y 13
.eqv WIN_SCREEN_END_Y 46

# fail screen start
# x is always 0
.eqv FAIL_SCREEN_START_Y 13
.eqv FAIL_SCREEN_END_Y 46

# player start
.eqv PLAYER_START_X 3
.eqv PLAYER_START_Y 41

# platform start
.eqv PLATFORM0_START_X 0
.eqv PLATFORM0_START_Y 42

.eqv PLATFORM1_START_X 15
.eqv PLATFORM1_START_Y 36

.eqv PLATFORM2_START_X 33
.eqv PLATFORM2_START_Y 30

.eqv PLATFORM3_START_X 46
.eqv PLATFORM3_START_Y 49

.eqv MOVING_PLATFORM_START_X 15
.eqv MOVING_PLATFORM_START_Y 36
.eqv MOVING_PLATFORM_SPEED 2
.eqv MOVING_PLAT_DEST 31

# sea start
.eqv SEA_START_X 0
.eqv SEA_START_Y 61

# health start
.eqv HEALTH_START_X 1
.eqv HEALTH_START_Y 1

# score start
.eqv SCORE_START_X 1
.eqv SCORE_START_Y 7

# additional objects start
.eqv MUSHROOM_START_X 36
.eqv MUSHROOM_START_Y 27
.eqv RED_MUSH_START_X 50
.eqv RED_MUSH_START_Y 46
.eqv ORANGE_MUSH_START_X 50
.eqv ORANGE_MUSH_START_Y 46

# physics
.eqv PLAYER_HORIZONTAL_SPEED 5
.eqv PLAYER_VERTICAL_UP_SPEED 10
.eqv PLAYER_VERTICAL_DOWN_SPEED 3
.eqv GRAVITY 1

# MMIO address
.eqv KEY_STATUS_ADDRESS 0xffff0000


.data
# health
HEALTH:		.word	HEALTH_START_X, HEALTH_START_Y # x, y

# score
SCORE:		.word	SCORE_START_X, SCORE_START_Y # x, y

# player
PLAYER:		.word	PLAYER_START_X, PLAYER_START_Y, 0 # x, y, is_grounded

# platform
PLATFORM0:	.word	PLATFORM0_START_X, PLATFORM0_START_Y, 8 # x, y, len
PLATFORM1:	.word	PLATFORM1_START_X, PLATFORM1_START_Y, 13
PLATFORM2:	.word	PLATFORM2_START_X, PLATFORM2_START_Y, 9
PLATFORM3:	.word	PLATFORM3_START_X, PLATFORM3_START_Y, 18
MOVING_PLATFORM:
		.word	MOVING_PLATFORM_START_X, MOVING_PLATFORM_START_Y, 13, MOVING_PLATFORM_SPEED, 0 # x, y, len, speed, as well as back_and_forth_state (0 means forth and 1 means back)

# screens
STARTER:	.word	0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 0, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0

WIN_SCREEN:	.word	0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0

FAIL_SCREEN:	.word 	0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0

# additional objects
MUSHROOM:	.word	MUSHROOM_START_X, MUSHROOM_START_Y, 1 # x, y, as well as existance (1 means mushroom still exists and 0 means mushroom does not exist)
RED_MUSH:	.word	RED_MUSH_START_X, RED_MUSH_START_Y, 1
ORANGE_MUSH:	.word	ORANGE_MUSH_START_X, ORANGE_MUSH_START_Y, 1		
		
.globl main
.text 
main:	
	# global variables
	# s0 = game state (0 means playing, 1 means win, 2 means lose, 3 means start)
	# s1 = health (initially 3 hearts)
	# s2 = score (initially 0 scores)
	# s3 = game round (0 means round 1, 1 means round 2)

	# initialize global variables
	li $s0, 3
	li $s1, 3
	li $s2, 0
	li $s3, 0
	
TICK:	
	# check game state
	beq $s1, 0, HAS_FAIL
	beq $s0, 3, START
	beq $s0, 1, HAS_WIN
	
	# --------------------------- Input ------------------------------
	
	INPUT:
		li $t9, KEY_STATUS_ADDRESS
		lw $t8, 0($t9)
		beq $t8, 0, COLLISION
	
		lw $t0, 4($t9) # key press
	
		KEYPRESS_HAPPENED:	# check key press
			CHECK_W_PRESS:
				beq $t0, KEY_W, RESPOND_TO_W
		
			CHECK_A_PRESS:
				
				beq $t0, KEY_A, RESPOND_TO_A
	
			CHECK_S_PRESS:
				beq $t0, KEY_S, RESPOND_TO_S
		
			CHECK_D_PRESS:
				beq $t0, KEY_D, RESPOND_TO_D	
				
			CHECK_R_PRESS:
				beq $t0, KEY_R, RESPOND_TO_R
				
			CHECK_Q_PRESS:
				beq $t0, KEY_Q, RESPOND_TO_Q
		
		# key responses	
		RESPOND_TO_W:
			jal HANDLE_W
			j COLLISION
		
		RESPOND_TO_A:
			jal HANDLE_A
			j COLLISION
	
		RESPOND_TO_S:
			jal HANDLE_S
			j COLLISION
		
		RESPOND_TO_D:
			jal HANDLE_D
			j COLLISION
			
		RESPOND_TO_R:
			jal RESET
			j TICK_SLEEP
			
		RESPOND_TO_Q:
			j END
	
	# ------------------------ End of Input --------------------------
	
	
	# ------------------------- Collision ----------------------------			
		
	COLLISION:
		la $t9, PLAYER
		
		jal CHECK_NEXT_ROUND
		beq $v0, 1, NEXT_ROUND_COLLISION
		
		jal CHECK_SEA_COLLISION
		beq $v0, 1, HEALTH_DOWN_SEA
		
		beqz $s3, ROUND_ONE_COLLISION
		
		# round 2
		jal CHECK_ORANGE_MUSH_COLLISION
		beq $v0, 1, HAS_ORANGE_MUSH
		
		jal CHECK_PLATFORM_COLLISION_TWO
		beqz $v0, GRAV
		sw $zero, 8($t9)
		
		j DRAW
		
		ROUND_ONE_COLLISION:	# round 1			
			jal CHECK_MUSHROOM_COLLISION
			beq $v0, 1, HAS_MUSHROOM
			
			jal CHECK_RED_MUSH_COLLISION
			beq $v0, 1, HAS_RED_MUSH
		
			jal CHECK_PLATFORM_COLLISION
			beqz $v0, GRAV
			sw $zero, 8($t9)
		
			j DRAW
		
		HEALTH_DOWN_SEA:
			subi $s1, $s1, 1
			
			jal RESET_POSITION
			
			j DRAW
			
		NEXT_ROUND_COLLISION:
			beq $s3, 1, HAS_WIN
		
			li $s3, 1
			
			jal RESET_POSITION
			
			j DRAW
	
		
	# ---------------------- End of Collision ------------------------
	
	
	# -------------------------- Gravity -----------------------------
	
	GRAV:	# apply gravity on the player
		jal APPLY_GRAVITY
		
		j DRAW
	
	# ---------------------	 End of Gravity -------------------------- 
	
	
	# -------------------------- Drawing -----------------------------
	
	DRAW:	# clear screen and draw new screen
		beqz $s3, ROUND_ONE
		
		# round 2
		jal CLEAR_SCREEN
		jal DRAW_HEALTH
		jal DRAW_SCORE
		jal DRAW_PLAYER
		jal DRAW_ORANGE_MUSH
		jal DRAW_PLATFORM_TWO
		jal DRAW_SEA
		
		j TICK_SLEEP
		
		
		ROUND_ONE:	# round 1
			jal CLEAR_SCREEN
			jal DRAW_HEALTH
			jal DRAW_SCORE
			jal DRAW_PLAYER
			jal DRAW_MUSHROOM
			jal DRAW_RED_MUSH
			jal DRAW_PLATFORM
			jal DRAW_SEA
		
			j TICK_SLEEP
		
	# ---------------------- End of Draw --------------------------
	
	# -------------------------- Screens -----------------------------
	
	START:
		li $s0, 3
		
		li $t9, KEY_STATUS_ADDRESS
		lw $t8, 0($t9)
		beq $t8, 0, NO_P_INPUT_IN_START
	
		lw $t0, 4($t9)
		
		CHECK_P_PRESS_IN_START:
			beq $t0, KEY_P, RESPOND_TO_P_IN_START
			
		RESPOND_TO_P_IN_START:
			jal HANDLE_P
			j DRAW
		
		NO_P_INPUT_IN_START:
			jal CLEAR_SCREEN
			jal DRAW_START_SCREEN
			j TICK_SLEEP
	
	HAS_FAIL:
		li $s0, 2
		
		li $t9, KEY_STATUS_ADDRESS
		lw $t8, 0($t9)
		beq $t8, 0, NO_P_INPUT_IN_FAIL
	
		lw $t0, 4($t9)
		
		CHECK_P_PRESS_IN_FAIL:
			beq $t0, KEY_P, RESPOND_TO_P_IN_FAIL
			
		RESPOND_TO_P_IN_FAIL:
			jal HANDLE_P
			jal RESET
			j DRAW
		
		NO_P_INPUT_IN_FAIL:
			jal CLEAR_SCREEN
			jal DRAW_FAIL_SCREEN
			j TICK_SLEEP
			
	HAS_WIN:
		li $s0, 1
		
		li $t9, KEY_STATUS_ADDRESS
		lw $t8, 0($t9)
		beq $t8, 0, NO_P_INPUT_IN_WIN
	
		lw $t0, 4($t9)
		
		CHECK_P_PRESS_IN_WIN:
			beq $t0, KEY_P, RESPOND_TO_P_IN_WIN
			
		RESPOND_TO_P_IN_WIN:
			jal HANDLE_P
			jal RESET
			j DRAW
		
		NO_P_INPUT_IN_WIN:
			jal CLEAR_SCREEN
			jal DRAW_WIN_SCREEN
			j TICK_SLEEP
		
	HAS_MUSHROOM:
		addi $s1, $s1, 1
		addi $s2, $s2, 1
		la $t1, MUSHROOM
		sw $zero, 8($t1)
		j TICK_SLEEP
		
	HAS_RED_MUSH:
		subi $s1, $s1, 1
		subi $s2, $s2, 1
		la $t1, RED_MUSH
		sw $zero, 8($t1)
		j TICK_SLEEP
		
	HAS_ORANGE_MUSH:
		addi $s2, $s2, 5
		la $t1, ORANGE_MUSH
		sw $zero, 8($t1)
		j TICK_SLEEP
		
	
	# ---------------------- End of Screens --------------------------
	
	
	# -------------------------- Restart -----------------------------
	TICK_SLEEP:	# restart screen
		li $v0, 32
		li $a0, SLEEP
		syscall
		j DONE_SLEEP
	
	DONE_SLEEP:
		j TICK
	
	# ----------------------- End of Restart -------------------------


END:	# end game
	li $v0, 10
	syscall


# -------------------------- Draw Functions -----------------------------

CLEAR_SCREEN:	# clear the screen for next drawing

	li $t0, BASE_ADDRESS
	li $t1, SCREEN_WIDTH
	li $t2, COLOR_BLACK
	li $t3, 4
		
	mult $t1, $t1
	mflo $t1
	mult $t1, $t3
	mflo $t1
	add $t1, $t0, $t1 # $t1 stores the last address to clear
		
	CLEAR_LOOP:
		bgt $t0, $t1, CLEAR_DONE
		sw $t2, 0($t0)
		add $t0, $t0, $t3
		j CLEAR_LOOP
			
	CLEAR_DONE:
		jr $ra

DRAW_PLAYER:	# draw player at current position
		
	la $t0, PLAYER
		
	lw $t1, 0($t0) # player's x pos
	lw $t2, 4($t0) # player's y pos
		
	li $t3, BASE_ADDRESS
	li $t4, SCREEN_WIDTH
	li $t5, 4
		
	mult $t2, $t4 # y * WIDTH
	mflo $t4
	add $t4, $t4, $t1 # y * WIDTH + x
	mult $t4, $t5 # (y * WIDTH + x) * 4
	mflo $t4
		
	add $t4, $t3, $t4 # offset by base address
		
	# draw
	li $t6, COLOR_GREEN
	li $t7, COLOR_CREAM
		
	sw $t6, -4($t4)
	sw $t6, 0($t4)
	sw $t6, 4($t4)
		
	addi $t4, $t4, -256
	sw $t6, -4($t4)
	sw $t6, 0($t4)
	sw $t6, 4($t4)
	
	addi $t4, $t4, -256
	sw $t6, -4($t4)
	sw $t6, 0($t4)
	sw $t6, 4($t4)
	
	addi $t4, $t4, -256
	sw $t6, -4($t4)
	sw $t6, 0($t4)
	sw $t6, 4($t4)
		
	addi $t4, $t4, -256
	sw $t7, -4($t4)
	sw $t7, 0($t4)
	sw $t7, 4($t4)
		
	addi $t4, $t4, -256
	sw $t7, -4($t4)
	sw $t7, 0($t4)
	sw $t7, 4($t4)
		
	addi $t4, $t4, -256
	sw $t7, -4($t4)
	sw $t7, 0($t4)
	sw $t7, 4($t4)
		
	jr $ra
		
DRAW_PLATFORM:	# draw platforms

	li $t4, BASE_ADDRESS
	li $t6, 4
	li $t7, COLOR_BROWN	
		
	# -------------------------- Platform 0 -----------------------------
		
	la $t0, PLATFORM0
		
	lw $t1, 0($t0) # x
	lw $t2, 4($t0) # y
	lw $t3, 8($t0) # len
		
	li $t5, SCREEN_WIDTH
		
	mult $t2, $t5 # y * WIDTH
	mflo $t5
	add $t5, $t5, $t1 # y * WIDTH + x
	mult $t5, $t6 # (y * WIDTH + x) * 4
	mflo $t5
		
	add $t5, $t4, $t5
		
	mult $t3, $t6
	mflo $t3
	add $t3, $t3, $t5
		
	PLATFORM0_LOOP:
		bgt $t5, $t3, PLATFORM0_DONE
		sw $t7, 0($t5)
		addi $t5, $t5, 4
		j PLATFORM0_LOOP
		
	PLATFORM0_DONE:
		
	# ---------------------- End of Platform 0 --------------------------
		
	# -------------------------- Platform 1 -----------------------------
		
	la $t0, PLATFORM1
		
	lw $t1, 0($t0) # x
	lw $t2, 4($t0) # y
	lw $t3, 8($t0) # len
		
	li $t5, SCREEN_WIDTH
		
	mult $t2, $t5 # y * WIDTH
	mflo $t5
	add $t5, $t5, $t1 # y * WIDTH + x
	mult $t5, $t6 # (y * WIDTH + x) * 4
	mflo $t5
		
	add $t5, $t4, $t5
		
	mult $t3, $t6
	mflo $t3
	add $t3, $t3, $t5
		
	PLATFORM1_LOOP:
		bgt $t5, $t3, PLATFORM1_DONE
		sw $t7, 0($t5)
		addi $t5, $t5, 4
		j PLATFORM1_LOOP
		
	PLATFORM1_DONE:
		
	# ---------------------- End of Platform 1 --------------------------
		
	# -------------------------- Platform 2 -----------------------------
		
	la $t0, PLATFORM2
		
	lw $t1, 0($t0) # x
	lw $t2, 4($t0) # y
	lw $t3, 8($t0) # len
		
	li $t5, SCREEN_WIDTH
		
	mult $t2, $t5 # y * WIDTH
	mflo $t5
	add $t5, $t5, $t1 # y * WIDTH + x
	mult $t5, $t6 # (y * WIDTH + x) * 4
	mflo $t5
		
	add $t5, $t4, $t5
		
	mult $t3, $t6
	mflo $t3
	add $t3, $t3, $t5
		
	PLATFORM2_LOOP:
		bgt $t5, $t3, PLATFORM2_DONE
		sw $t7, 0($t5)
		addi $t5, $t5, 4
		j PLATFORM2_LOOP
		
	PLATFORM2_DONE:
		
	# ---------------------- End of Platform 2 --------------------------
		
	# -------------------------- Platform 3 -----------------------------
		
	la $t0, PLATFORM3
		
	lw $t1, 0($t0) # x
	lw $t2, 4($t0) # y
	lw $t3, 8($t0) # len
		
	li $t5, SCREEN_WIDTH
		
	mult $t2, $t5 # y * WIDTH
	mflo $t5
	add $t5, $t5, $t1 # y * WIDTH + x
	mult $t5, $t6 # (y * WIDTH + x) * 4
	mflo $t5
		
	add $t5, $t4, $t5
		
	mult $t3, $t6
	mflo $t3
	add $t3, $t3, $t5
		
	PLATFORM3_LOOP:
		bgt $t5, $t3, PLATFORM3_DONE
		sw $t7, 0($t5)
		addi $t5, $t5, 4
		j PLATFORM3_LOOP
		
	PLATFORM3_DONE:
		
	# ---------------------- End of Platform 3 --------------------------
		
	jr $ra
		
DRAW_PLATFORM_TWO:	# draw platform in round 2
	li $t4, BASE_ADDRESS
	li $t6, 4
	li $t7, COLOR_BROWN	
		
	# -------------------------- Platform 0 -----------------------------
	
	la $t0, PLATFORM0
		
	lw $t1, 0($t0) # x
	lw $t2, 4($t0) # y
	lw $t3, 8($t0) # len
		
	li $t5, SCREEN_WIDTH
		
	mult $t2, $t5 # y * WIDTH
	mflo $t5
	add $t5, $t5, $t1 # y * WIDTH + x
	mult $t5, $t6 # (y * WIDTH + x) * 4
	mflo $t5
		
	add $t5, $t4, $t5
		
	mult $t3, $t6
	mflo $t3
	add $t3, $t3, $t5
		
	PLATFORM0_LOOP_TWO:
		bgt $t5, $t3, PLATFORM0_DONE_TWO
		sw $t7, 0($t5)
		addi $t5, $t5, 4
		j PLATFORM0_LOOP_TWO
		
	PLATFORM0_DONE_TWO:
		
	# ---------------------- End of Platform 0 --------------------------
		
	# -------------------------- Moving Platform -----------------------------
		
	la $t0, MOVING_PLATFORM
		
	lw $t1, 0($t0) # x
	lw $t2, 4($t0) # y
	lw $t3, 8($t0) # len
		
	li $t5, SCREEN_WIDTH
		
	mult $t2, $t5 # y * WIDTH
	mflo $t5
	add $t5, $t5, $t1 # y * WIDTH + x
	mult $t5, $t6 # (y * WIDTH + x) * 4
	mflo $t5
		
	add $t5, $t4, $t5
		
	mult $t3, $t6
	mflo $t3
	add $t3, $t3, $t5
		
	MOVING_PLATFORM_LOOP:
		bgt $t5, $t3, MOVING_PLATFORM_DONE
		sw $t7, 0($t5)
		addi $t5, $t5, 4
		j MOVING_PLATFORM_LOOP
		
	MOVING_PLATFORM_DONE:
		lw $t8, 16($t0) # 0 means forth and 1 means back
		lw $t9, 12($t0) # speed
		
		beq $t8, 1, MOVING_BACK
			
		add $t1, $t1, $t9
		sw $t1, 0($t0)
		beq $t1, MOVING_PLAT_DEST, UPDATE_PLAT_FORTH_STATE
		j MOVING_UPDATE_DONE
			
		UPDATE_PLAT_FORTH_STATE:
			li $t8, 1
			sw $t8, 16($t0)
			j MOVING_UPDATE_DONE
			
		MOVING_BACK:
			sub $t1, $t1, $t9
			sw $t1, 0($t0)
			beq $t1, MOVING_PLATFORM_START_X, UPDATE_PLAT_BACK_STATE
			j MOVING_UPDATE_DONE
				
			UPDATE_PLAT_BACK_STATE:
				li $t8, 0
				sw $t8, 16($t0)
				j MOVING_UPDATE_DONE
	MOVING_UPDATE_DONE:
		
	# ---------------------- End of Moving Platform --------------------------
		
	# -------------------------- Platform 2 -----------------------------
		
	la $t0, PLATFORM3
		
	lw $t1, 0($t0) # x
	lw $t2, 4($t0) # y
	lw $t3, 8($t0) # len
		
	li $t5, SCREEN_WIDTH
		
	mult $t2, $t5 # y * WIDTH
	mflo $t5
	add $t5, $t5, $t1 # y * WIDTH + x
	mult $t5, $t6 # (y * WIDTH + x) * 4
	mflo $t5
		
	add $t5, $t4, $t5
		
	mult $t3, $t6
	mflo $t3
	add $t3, $t3, $t5
		
	PLATFORM3_LOOP_TWO:
		bgt $t5, $t3, PLATFORM3_DONE_TWO
		sw $t7, 0($t5)
		addi $t5, $t5, 4
		j PLATFORM3_LOOP_TWO
		
	PLATFORM3_DONE_TWO:
		
	# ---------------------- End of Platform 2 --------------------------
		
	jr $ra
		
DRAW_SEA:	# draw sea

	li $t0, SEA_START_X
	li $t1, SEA_START_Y
		
	li $t2, BASE_ADDRESS
	li $t3, SCREEN_WIDTH
	li $t4, 4
		
	mult $t1, $t3 # y * WIDTH
	mflo $t3
	add $t3, $t3, $t0 # y * WIDTH + x
	mult $t3, $t4 # (y * WIDTH + x) * 4
	mflo $t3
		
	add $t3, $t2, $t3
		
	addi $t5, $t3, 768
		
	li $t6, COLOR_BLUE
		
	SEA_LOOP_ONCE:
		bgt $t3, $t5, SEA_DONE_ONCE
		sw $t6, 0($t3)
		addi $t3, $t3, 4
		j SEA_LOOP_ONCE
			
	SEA_DONE_ONCE:
		jr $ra
			
DRAW_WIN_SCREEN:	# draw win screen
	li $t4, COLOR_WHITE
	
	li $t0, BASE_ADDRESS
	
	li $t1, 13
	li $t2, 256
	mult $t1, $t2
	mflo $t1 
	
	add $t0, $t0, $t1
	
	li $t1, 34
	mult $t1, $t2
	mflo $t1
	
	add $t3, $t0, $t1
	
	la $t5, WIN_SCREEN
	
	WIN_SCREEN_LOOP:	
		bgt $t0, $t3, WIN_SCREEN_DONE
		
		lw $t6, 0($t5)
		
		beqz $t6, WIN_SCREEN_IF_DONE
		
		sw $t4, 0($t0)
		
		WIN_SCREEN_IF_DONE:
			addi $t0, $t0, 4
			addi $t5, $t5, 4
			
			j WIN_SCREEN_LOOP
			
	WIN_SCREEN_DONE:
		jr $ra

DRAW_FAIL_SCREEN:	# draw fail screen
	li $t4, COLOR_WHITE
	
	li $t0, BASE_ADDRESS
	
	li $t1, 13
	li $t2, 256
	mult $t1, $t2
	mflo $t1 
	
	add $t0, $t0, $t1
	
	li $t1, 34
	mult $t1, $t2
	mflo $t1
	
	add $t3, $t0, $t1
	
	la $t5, FAIL_SCREEN
	
	FAIL_SCREEN_LOOP:	
		bgt $t0, $t3, FAIL_SCREEN_DONE
		
		lw $t6, 0($t5)
		
		beqz $t6, FAIL_SCREEN_IF_DONE
		
		sw $t4, 0($t0)
		
		FAIL_SCREEN_IF_DONE:
			addi $t0, $t0, 4
			addi $t5, $t5, 4
			
			j FAIL_SCREEN_LOOP
			
	FAIL_SCREEN_DONE:
		jr $ra
		
DRAW_START_SCREEN:	# draw start screen
	li $t4, COLOR_WHITE
	
	li $t0, BASE_ADDRESS
	
	li $t1, 13
	li $t2, 256
	mult $t1, $t2
	mflo $t1 
	
	add $t0, $t0, $t1
	
	li $t1, 34
	mult $t1, $t2
	mflo $t1
	
	add $t3, $t0, $t1
	
	la $t5, STARTER
	
	START_SCREEN_LOOP:	
		bgt $t0, $t3, START_SCREEN_DONE
		
		lw $t6, 0($t5)
		
		beqz $t6, START_SCREEN_IF_DONE
		
		sw $t4, 0($t0)
		
		START_SCREEN_IF_DONE:
			addi $t0, $t0, 4
			addi $t5, $t5, 4
			
			j START_SCREEN_LOOP
			
	START_SCREEN_DONE:
		jr $ra
		
DRAW_HEALTH:	# draw health
	li $t0, COLOR_RED
	
	la $t1, HEALTH
	lw $t2, 0($t1) # x
	lw $t3, 4($t1) # y
	
	li $t4, BASE_ADDRESS
	li $t5, SCREEN_WIDTH
	li $t6, 4
	
	li $t8, 0 # i
	
	DRAW_HEALTH_LOOP:
		bge $t8, $s1, DRAW_HEALTH_DONE
		
		mult $t3, $t5 # y * WIDTH
		mflo $t7
		add $t7, $t7, $t2 # y * WIDTH + x
		mult $t7, $t6 # (y * WIDTH + x) * 4
		mflo $t7
		add $t7, $t4, $t7 # offset by base address
		
		sw $t0, 0($t7)
		addi $t7, $t7, 256
		sw $t0, 0($t7)
		addi $t7, $t7, 256
		sw $t0, 0($t7)
		
		addi $t2, $t2, 2
		addi $t8, $t8, 1
		
		j DRAW_HEALTH_LOOP
		
	DRAW_HEALTH_DONE:
		jr $ra
		
DRAW_SCORE:	# draw health
	li $t0, COLOR_BLUE
	
	la $t1, SCORE
	lw $t2, 0($t1) # x
	lw $t3, 4($t1) # y
	
	li $t4, BASE_ADDRESS
	li $t5, SCREEN_WIDTH
	li $t6, 4
	
	li $t8, 0 # i
	
	DRAW_SCORE_LOOP:
		bge $t8, $s2, DRAW_SCORE_DONE
		
		mult $t3, $t5 # y * WIDTH
		mflo $t7
		add $t7, $t7, $t2 # y * WIDTH + x
		mult $t7, $t6 # (y * WIDTH + x) * 4
		mflo $t7
		add $t7, $t4, $t7 # offset by base address
		
		sw $t0, 0($t7)
		addi $t7, $t7, 256
		sw $t0, 0($t7)
		addi $t7, $t7, 256
		sw $t0, 0($t7)
		
		addi $t2, $t2, 2
		addi $t8, $t8, 1
		
		j DRAW_SCORE_LOOP
		
	DRAW_SCORE_DONE:
		jr $ra

	
DRAW_MUSHROOM:	# draw mushroom
	la $t2, MUSHROOM
	lw $t5, 8($t2)
	
	beqz $t5, DRAW_MUSHROOM_DONE

	li $t0, COLOR_LIGHT_BROWN
	li $t1, COLOR_LIGHT_YELLOW

	lw $t3, 0($t2) # mushroom's x
	lw $t4, 4($t2) # y
	
	li $t5, BASE_ADDRESS
	li $t6, SCREEN_WIDTH
	li $t7, 4
	
	mult $t4, $t6 # y * WIDTH
	mflo $t6
	add $t6, $t6, $t3 # y * WIDTH + x
	mult $t6, $t7 # (y * WIDTH + x) * 4
	mflo $t6
	add $t6, $t5, $t6 # offset by base address
	
	sw $t0, 4($t6)
	addi $t6, $t6, 256
	sw $t0, 0($t6)
	sw $t0, 4($t6)
	sw $t0, 8($t6)
	addi $t6, $t6, 256
	sw $t1, 4($t6)
	
	DRAW_MUSHROOM_DONE:
		jr $ra
	
DRAW_RED_MUSH:	# draw red mushroom
	la $t2, RED_MUSH
	lw $t5, 8($t2)
	
	beqz $t5, DRAW_RED_MUSH_DONE

	li $t0, COLOR_RED
	li $t1, COLOR_LIGHT_YELLOW

	lw $t3, 0($t2) # red mush's x
	lw $t4, 4($t2) # y
	
	li $t5, BASE_ADDRESS
	li $t6, SCREEN_WIDTH
	li $t7, 4
	
	mult $t4, $t6 # y * WIDTH
	mflo $t6
	add $t6, $t6, $t3 # y * WIDTH + x
	mult $t6, $t7 # (y * WIDTH + x) * 4
	mflo $t6
	add $t6, $t5, $t6 # offset by base address
	
	sw $t0, 4($t6)
	addi $t6, $t6, 256
	sw $t0, 0($t6)
	sw $t0, 4($t6)
	sw $t0, 8($t6)
	addi $t6, $t6, 256
	sw $t1, 4($t6)
	
	DRAW_RED_MUSH_DONE:
		jr $ra
		
DRAW_ORANGE_MUSH:	# draw orange mushroom
	la $t2, ORANGE_MUSH
	lw $t5, 8($t2)
	
	beqz $t5, DRAW_ORANGE_MUSH_DONE

	li $t0, COLOR_ORANGE
	li $t1, COLOR_LIGHT_YELLOW

	lw $t3, 0($t2) # orange mush's x
	lw $t4, 4($t2) # y
	
	li $t5, BASE_ADDRESS
	li $t6, SCREEN_WIDTH
	li $t7, 4
	
	mult $t4, $t6 # y * WIDTH
	mflo $t6
	add $t6, $t6, $t3 # y * WIDTH + x
	mult $t6, $t7 # (y * WIDTH + x) * 4
	mflo $t6
	add $t6, $t5, $t6 # offset by base address
	
	sw $t0, 4($t6)
	addi $t6, $t6, 256
	sw $t0, 0($t6)
	sw $t0, 4($t6)
	sw $t0, 8($t6)
	addi $t6, $t6, 256
	sw $t1, 4($t6)
	
	DRAW_ORANGE_MUSH_DONE:
		jr $ra
				
# ---------------------- End of Drawing --------------------------

# ---------------------- Handle Inputs ---------------------------

HANDLE_W:       # handle input w
    		la $t0, PLAYER

    		lw $t1, 4($t0)     # Load player's vertical position
    		lw $t2, 8($t0)     # Load player's jump count

    		# Check if the player has already jumped twice
    		li $t3, 2
    		bge $t2, $t3, JUMP_END

    		JUMP:
        		subi $t1, $t1, PLAYER_VERTICAL_UP_SPEED     # Adjust vertical position for jump

       	 		# Update jump count
        		addi $t2, $t2, 1
        		sw $t2, 8($t0)     # Store updated jump count back to player's data structure

        		sw $t1, 4($t0)     # Store updated vertical position back to player's data structure

    		JUMP_END:
        		li $s4, 0     # Reset jump number
        		jr $ra
    		
		
HANDLE_A:	# handle input a
		la $t0, PLAYER
		
		lw $t1, 0($t0)
		
		subi $t2, $t1, PLAYER_HORIZONTAL_SPEED
		
		bltz $t2, STOP_GOING_LEFT
		
		subi $t1, $t1, PLAYER_HORIZONTAL_SPEED
		
		sw $t1, 0($t0)
		
		jr $ra
		
		STOP_GOING_LEFT:
		
		jr $ra
		
HANDLE_S:	# handle input s
		la $t0, PLAYER
		
		lw $t1, 4($t0)
		
		addi $t1, $t1, PLAYER_VERTICAL_DOWN_SPEED
		
		sw $t1, 4($t0)
		
		jr $ra
		
HANDLE_D:	# handle input d
		la $t0, PLAYER
		
		lw $t1, 0($t0)
		
		addi $t2, $t1, 1
		
		bge $t2, 63, STOP_GOING_RIGHT
		
		addi $t1, $t1, PLAYER_HORIZONTAL_SPEED
		
		sw $t1, 0($t0)
		
		jr $ra
		
		STOP_GOING_RIGHT:
		
			jr $ra
		
HANDLE_P:	# handle input p
		li $s0, 0
		
		jr $ra		
		
# -------------------- End of Handle Input ------------------------		
		
		
# ---------------------- Handle Gravity ---------------------------		
APPLY_GRAVITY:	# apply gravity to player
	la $t0, PLAYER
		
	lw $t1, 4($t0)
		
	addi $t1, $t1, GRAVITY
		
	sw $t1, 4($t0)
		
	jr $ra

# -------------------- End of Handle Gravity ------------------------		
		
# ---------------------- Handle Collision ---------------------------	

CHECK_NEXT_ROUND:	# check if the player reaches rightest. if so, return 1. otherwise, return 0.
			# $v0 stores return value
	li $v0, 0
	
	la $t0, PLAYER
	lw $t1, 0($t0) # player's x
	
	blt $t1, 62, NO_NEXT_ROUND
	
	li $v0, 1
	
	jr $ra
	
	NO_NEXT_ROUND:
		jr $ra
		

CHECK_PLATFORM_COLLISION: 	# check if the player collides with all the platforms. if so, return 1, otherwise, return 0.
				# $v0 stores return value
	move $a0, $ra
	
	li $v0, 0 # reset $v0
	li $t0, 1
	la $a1, PLAYER # address of PLAYER
	
	la $a2, PLATFORM0 # address of PLATFORM0
	jal CHECK_SINGLE_PLATFORM_COLLISION
	beq $v0, $t0, PLATFORM_COLLISIONS
	
	la $a2, PLATFORM1 # address of PLATFORM1
	jal CHECK_SINGLE_PLATFORM_COLLISION
	beq $v0, $t0, PLATFORM_COLLISIONS
	
	la $a2, PLATFORM2 # address of PLATFORM2
	jal CHECK_SINGLE_PLATFORM_COLLISION
	beq $v0, $t0, PLATFORM_COLLISIONS
	
	la $a2, PLATFORM3 # address of PLATFORM3
	jal CHECK_SINGLE_PLATFORM_COLLISION
	beq $v0, $t0, PLATFORM_COLLISIONS
	
	# jr $ra
	
	PLATFORM_COLLISIONS:
		move $ra, $a0
		
		jr $ra
		
CHECK_PLATFORM_COLLISION_TWO:	# check if the player collides with the platform in round 2. if so, return 1, otherwise, return 0.
				# $v0 stores return value
	move $a0, $ra
	
	li $v0, 0 # reset $v0
	la $a1, PLAYER # address of PLAYER
	
	la $a2, PLATFORM0 # address of PLATFORM0
	jal CHECK_SINGLE_PLATFORM_COLLISION
	beq $v0, 1, PLATFORM_COLLISIONS_TWO
	
	la $a2, MOVING_PLATFORM # address of PLATFORM1
	jal CHECK_SINGLE_PLATFORM_COLLISION
	beq $v0, 1, PLATFORM_COLLISIONS_TWO
	
	la $a2, PLATFORM3 # address of PLATFORM3
	jal CHECK_SINGLE_PLATFORM_COLLISION
	beq $v0, 1, PLATFORM_COLLISIONS_TWO
	
	PLATFORM_COLLISIONS_TWO:
		move $ra, $a0
		
		jr $ra

CHECK_SINGLE_PLATFORM_COLLISION:	# check if the player collides with the platform. if so, return 1. otherwise, return 0. 
				 	#($a1 stores player address, $a2 stores platform address, and $v0 stores return value.
	li $v0, 0 # reset $v0
	
	lw $t1, 0($a1) # PLAYER's x
	lw $t2, 4($a1) # y
	
	lw $t3, 0($a2) # PLATFORM's x (x lower bound)
	lw $t4, 4($a2) # y
	lw $t5, 8($a2) # len
	
	add $t6, $t3, $t5
	subi $t6, $t6, 1 # x upper bound
	
	subi $t4, $t4, 1 
	
	bne $t2, $t4, NO_PLATFORM_COLLISION # PLAYER's y != collision y
	bgt $t1, $t6, NO_PLATFORM_COLLISION # PLAYER's x > x upper bound
	blt $t1, $t3, NO_PLATFORM_COLLISION # PLAYER's x < x lower bound
	
	li $v0, 1
	
	jr $ra
	
	NO_PLATFORM_COLLISION:
		li $v0, 0
		
		jr $ra
		
CHECK_SEA_COLLISION:	# check if the player collides with the sea. if so, return 1. otherwise, return 0.
			# ($v0 stores return value)	
	li $v0, 0
	
	la $t2, PLAYER
	
	li $t0, SEA_START_Y # SEA's y
	lw $t1, 4($t2) # PLAYER's y
	
	blt $t1, $t0, NO_SEA_COLLISION
	
	li $v0, 1
	
	jr $ra
	
	NO_SEA_COLLISION:
		
		jr $ra

CHECK_MUSHROOM_COLLISION:	# check if the player collides with the mushroom. if so, return 1. otherwise, return 0.
				# ($v0 stores return value)
	li $v0, 0
	
	la $t3, MUSHROOM
	lw $t6, 8($t3)
	
	beqz $t6, NO_MUSHROOM_COLLISION
	
	la $t0, PLAYER
	lw $t1, 0($t0) # player's x
	lw $t2, 4($t0) # y
	
	lw $t4, 0($t3) # mushroom's x
	lw $t5, 4($t3) # y
	addi $t6, $t4, 2 # upper x
	addi $t7, $t5, 2 # upper y
	
	blt $t1, $t4, NO_MUSHROOM_COLLISION
	bgt $t2, $t6, NO_MUSHROOM_COLLISION
	blt $t2, $t5, NO_MUSHROOM_COLLISION
	bgt $t2, $t7, NO_MUSHROOM_COLLISION
	
	li $v0, 1
	
	NO_MUSHROOM_COLLISION:
		 jr $ra

CHECK_RED_MUSH_COLLISION:	# check if the player collides with the red mushroom. if so, return 1. otherwise, return 0.
				# ($v0 stores return value)
	li $v0, 0
	
	la $t3, RED_MUSH
	lw $t6, 8($t3)
	
	beqz $t6, NO_RED_MUSH_COLLISION
	
	la $t0, PLAYER
	lw $t1, 0($t0) # player's x
	lw $t2, 4($t0) # y
	
	lw $t4, 0($t3) # mushroom's x
	lw $t5, 4($t3) # y
	addi $t6, $t4, 2 # upper x
	addi $t7, $t5, 2 # upper y
	
	blt $t1, $t4, NO_RED_MUSH_COLLISION
	bgt $t2, $t6, NO_RED_MUSH_COLLISION
	blt $t2, $t5, NO_RED_MUSH_COLLISION
	bgt $t2, $t7, NO_RED_MUSH_COLLISION
	
	li $v0, 1
	
	NO_RED_MUSH_COLLISION:
		 jr $ra		
		 
CHECK_ORANGE_MUSH_COLLISION:	# check if the player collides with the orange mushroom. if so, return 1. otherwise, return 0.
				# ($v0 stores return value)
	li $v0, 0
	
	la $t3, ORANGE_MUSH
	lw $t6, 8($t3)
	
	beqz $t6, NO_ORANGE_MUSH_COLLISION
	
	la $t0, PLAYER
	lw $t1, 0($t0) # player's x
	lw $t2, 4($t0) # y
	
	lw $t4, 0($t3) # orange mush's x
	lw $t5, 4($t3) # y
	addi $t6, $t4, 2 # upper x
	addi $t7, $t5, 2 # upper y
	
	blt $t1, $t4, NO_ORANGE_MUSH_COLLISION
	bgt $t2, $t6, NO_ORANGE_MUSH_COLLISION
	blt $t2, $t5, NO_ORANGE_MUSH_COLLISION
	bgt $t2, $t7, NO_ORANGE_MUSH_COLLISION
	
	li $v0, 1
	
	NO_ORANGE_MUSH_COLLISION:
		 jr $ra

# -------------------- End of Handle Collision ----------------------		

# ------------------------------ Reset --------------------------------

RESET:	#reset
	# reset player position
	la $t0, PLAYER
	
	li $t1, PLAYER_START_X
	li $t2, PLAYER_START_Y
	
	sw $t1, 0($t0)
	sw $t2, 4($t0)
	
	# reset health
	li $s1, 3
	
	# reset objects
	la $t3, MUSHROOM
	la $t4, RED_MUSH
	la $t5, ORANGE_MUSH
	li $t6, 1
	sw $t6, 8($t3)
	sw $t6, 8($t4)
	sw $t6, 8($t5)
	
	# reset game mode
	li $s0, 0
	li $s2, 0
	li $s3, 0
	
	jr $ra
	
RESET_POSITION:	# reset player position
	la $t0, PLAYER
	
	li $t1, PLAYER_START_X
	li $t2, PLAYER_START_Y
	
	sw $t1, 0($t0)
	sw $t2, 4($t0)
	
	jr $ra

# -------------------------- End of Reset -----------------------------
