MATRIX4_PATH := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
MATRIX4_MAIN_OBJ := $(MATRIX4_PATH)Matrix4.o
MATRIX4_CFLAGS := -std=c++17 -O3
MATRIX4_LFLAGS :=

MATRIX4_OBJDIR := $(MATRIX4_PATH).ObjectFiles/
Matrix4ObjectDirectory:
	mkdir -p $(MATRIX4_OBJDIR)
	mkdir -p $(MATRIX4_OBJDIR)src/
	@echo "- - - - Matrix4 ObjectFile directory created - - - -"

_MATRIX4_DEPS := src/Matrix4.hpp
MATRIX4_DEPS := $(foreach OBJ,$(_MATRIX4_DEPS),$(MATRIX4_PATH)$(OBJ))

_MATRIX4_SUB_OBJS := \
	src/Constructors.o \
	src/Friend.o \
	src/Miscellaneous.o \
	src/OperatorOverloads.o \
	src/Static.o \
	src/Transformations.o \
	src/Vector.o
MATRIX4_SUB_OBJS := \
	$(foreach OBJ,$(_MATRIX4_SUB_OBJS),$(MATRIX4_OBJDIR)$(OBJ))


# --- Rules ---

# Main object
$(MATRIX4_MAIN_OBJ): $(MATRIX4_SUB_OBJS)
	@echo "- - - - Matrix4 compiled - - - -"
	$(LD) -r $(MATRIX4_LFLAGS) $(MATRIX4_SUB_OBJS) -o $@
	@echo "- - - - Matrix4 linked - - - -"

# Sub objects
$(MATRIX4_OBJDIR)%.o: $(MATRIX4_PATH)%.cpp $(MATRIX4_DEPS)
	$(CC) -c $(MATRIX4_CFLAGS) $< -o $@

# Clean
Matrix4Clean:
	rm -f $(MATRIX4_SUB_OBJS) $(MATRIX4_MAIN_OBJ)
