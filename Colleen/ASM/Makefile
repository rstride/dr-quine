CC_FLAGS	=	-Wall -Wextra -Werror
NASM_FLAGS	=	-felf64

SRCS		=	Colleen.s
OBJS		=	$(SRCS:%.s=%.o)
NAME		=	Colleen

all:			$(NAME)

$(NAME):		$(OBJS)
				gcc $(CC_FLAGS) -no-pie $(OBJS) -o $(NAME)

%.o: %.s
				nasm $(NASM_FLAGS) $< -o $@

clean:
ifneq (,$(wildcard $(OBJS)))
				rm -rf $(OBJS)
endif

fclean:			clean
ifneq (,$(wildcard $(NAME)))
				rm -rf $(NAME)
endif

re:				fclean
				@$(MAKE) --no-print-directory

.PHONY:			all clean fclean re