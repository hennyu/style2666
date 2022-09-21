#!/usr/bin/env python3
# -*- coding: utf-8 -*-


from os.path import join
from lexicalrichness import LexicalRichness

# compute lexical richness for the five parts of Roberto Bolaño's novel 2666, using the module LexicalRichness
# @author: Ulrike Henny-Krahmer


wdir = "/home/ulrike/Git/style2666_internal"
textdir = "text/txt_parts"
part = "bolano-2666-part1.txt"

f = open(join(wdir, textdir, part), "r")
text = f.read() 

# test example sentences
#text ="Durante aquella semana el teléfono fijo de Liz Norton sonaba tres o cuatro veces cada tarde y el teléfono móvil dos o tres veces cada mañana."
#text ="Cinco días después, antes de que acabara el mes de enero, fue estrangulada Luisa Celina Vázquez."

lex = LexicalRichness(text)

print(lex.words)
print(lex.terms)
print(lex.ttr)
#print(lex.mattr(window_size=500))
print(lex.mtld(threshold=0.72))
