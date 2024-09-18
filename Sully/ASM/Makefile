CC_FLAGS	=	-Wall -Wextra -Werror
NASM_FLAGS	=	-felf64

SRCS		=	Sully.s
OBJS		=	$(SRCS:%.s=%.o)
NAME		=	Sully

all:			$(NAME)

$(NAME):		$(OBJS)
				gcc $(CC_FLAGS) -no-pie -nostartfiles $(OBJS) -o $(NAME)

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