# params.mk :: per-student build parameters, derived from your Student ID.
# Included by the webserver and dbserver Makefiles. Do NOT edit the formulas -
# the marking process recomputes these from your SID and checks they match your
# configuration, your running containers and your evidence.

SID ?= u1234567

# strip a leading 'u' from the SID, then take its trailing digits
SID_NUM  := $(SID:u%=%)
LAST2    := $(shell printf '%s' '$(SID_NUM)' | tail -c 2)
LAST3    := $(shell printf '%s' '$(SID_NUM)' | tail -c 3)

# APP_UID  = 20000 + last THREE digits of your SID (non-root user for the app)
# APP_PORT = 8000  + last TWO   digits of your SID (internal port for the app/proxy)
APP_UID  := $(shell expr 20000 + $(LAST3))
APP_PORT := $(shell expr 8000 + $(LAST2))

# `make params` prints your personal values
params:
	@echo "SID      = $(SID)"
	@echo "APP_UID  = $(APP_UID)   (non-root user your app container must run as)"
	@echo "APP_PORT = $(APP_PORT)   (internal port your app / reverse proxy must listen on)"

# `make help` prints an orientation from the command line
help:
	@echo "CYBERDELIA :: 7009SCN coursework"
	@echo "  New here?  Open START_HERE.md, then ASSESSMENT_REQUIREMENTS.md."
	@echo ""
	@echo "Commands (run in dbserver/ first, then webserver/):"
	@echo "  make         build the image"
	@echo "  make run     start the container"
	@echo "  make clean   stop and remove it"
	@echo "  make params  show your APP_UID / APP_PORT (derived from your SID)"
	@echo "  make help    show this message"
	@echo ""
	@echo "Quick start: set your SID in the Makefile, then:"
	@echo "  cd dbserver    && make && make run"
	@echo "  cd ../webserver && make && make run"
	@echo "  open http://localhost/"

.PHONY: params help
