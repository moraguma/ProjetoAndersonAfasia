# Jogo de Afasia por um Afásico
# Copyright (C) 2025 Gustavo Araújo Morais
# 
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.

from gtts import gTTS
import os

texts = {
    #"playerselection": "Escolha seu personagem",
    "ttsenabled": "Assistente de voz habilitado",
    "ttsdisabled": "Assistente de voz desabilitado",
    #"1prompt": "Onde você pode sentar?",
    #"1win": "Parabéns! Dá pra sentar nisso!",
    #"1lose": "Não dá pra sentar nisso!",
    #"2prompt": "Qual esporte usa bola?",
    #"2win": "Parabéns! Esse esporte usa bola!",
    #"2lose": "Esse esporte não usa bola!",
    #"3prompt": "O que ajuda a proteger do sol na cabeça?",
    #"3win": "Parabéns! Isso protege do sol!",
    #"3lose": "Isso não protege do sol!",
    #"4prompt": "O que eu posso usar para ver as horas",
    #"4win": "Parabéns! Isso se usa pra ver as horas!",
    #"4lose": "Isso não ajuda a ver as horas!",
    #"5prompt": "Onde você pode deitar para dormir?",
    #"5win": "Parabéns! Dá pra dormir nisso!",
    #"5lose": "Não dá pra dormir nisso!",
    #"6prompt": "Onde você pode escrever?",
    #"6win": "Parabéns! Dá pra escrever nisso!",
    #"6lose": "Não dá pra escrever nisso!",
    #"7prompt": "O que você pode beber?",
    #"7win": "Parabéns! Dá pra beber isso!",
    #"7lose": "Não dá pra beber isso!",
    #"8prompt": "Que animal morde?",
    #"8win": "Parabéns! Esse animal morde!",
    #"8lose": "Esse animal não morde!",
    #"9prompt": "O que você pode usar para se locomover?",
    #"9win": "Parabéns! Dá pra se locomover nisso!",
    #"9lose": "Não dá pra se locomover nisso!",
    #"10prompt": "O que te ajuda a enxergar melhor?",
    #"10win": "Parabéns! Isso ajuda a enxergar melhor!",
    #"10lose": "Isso não ajuda a enxergar!",
}

language = 'pt'

for filename in texts:
    tts = gTTS(text=texts[filename], lang=language, slow=False)
    tts.save(f"resources\\\sounds\\tts\\{filename}.mp3")