CC_FLAGS	=	-Wall -Wextra -Werror

SRCS		=	Grace.c
OBJS		=	$(SRCS:%.c=%.o)
NAME		=	Grace

all:			$(NAME)

$(NAME):		$(OBJS)
				gcc $(CC_FLAGS) $(OBJS) -o $(NAME)

%.o: %.c
				gcc $(CC_FLAGS) -c $< -o $@

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