NAME = iter
CC = c++

INC_DIR = .
# To remove ./ from the find result -> cut
INC = $(shell find $(INC_DIR) -type f -name "*.h*" | cut -c 3- )

DEBUG =
FLAGS = -Wall -Wextra -Werror $(DEBUG) -std=c++98

OBJ_DIR = obj
SRC_DIR = srcs

SRC :=	main.cpp

OBJ = $(patsubst $(SRC_DIR)/%.cpp, $(OBJ_DIR)/%.o, $(SRC))

# ----- COLORS -----
ON_BLUE = \033[44m
ON_CYAN = \033[46m
ON_GREEN = \033[42m
ON_PURPLE = \033[45m
BBLUE = \033[1;34m
BCYAN = \033[1;36m
BGREEN = \033[1;32m
BLUE = \033[0;34m
CYAN = \033[0;36m
PURPLE = \033[0;35m
EOC = \033[m
# ------------------

all: $(NAME)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp $(INC)
	@mkdir -p $(dir $(OBJ_DIR)/$*)
	@$(CC) $(FLAGS) -c $< -o $@ $(LIBS)
	@echo "$(CYAN)Creating: $(@:%=%)$(EOC)"

$(NAME) : $(OBJ) $(INC)
	@$(CC) $(FLAGS) -o $(NAME) $(OBJ)  $(LIBS)
	@echo "$(ON_BLUE)- $(NAME) Compilation Completed -$(EOC)"
clean:
	@if [ -d $(OBJ_DIR) ]; then rm -rf $(OBJ_DIR) && echo "$(PURPLE)Removing: $(NAME) Object Files$(EOC)"; else echo "make: No $(NAME) objects to remove."; fi

fclean: clean
	@if [ -f $(NAME) ]; then rm -f $(NAME) && echo "$(ON_PURPLE)Removing - $(NAME) -$(EOC)"; else echo "make: No binary $(NAME) to remove."; fi;

re: fclean all

.PHONY: all clean fclean re
