# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: shedelin <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/06/27 14:59:22 by shedelin          #+#    #+#              #
#    Updated: 2015/06/27 14:59:23 by shedelin         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

RESULT = instant_tama
SOURCES = action.ml \
		main.ml
PACKS = lablgtk2
OCAML  = OCamlMakefile
include $(OCAML)
