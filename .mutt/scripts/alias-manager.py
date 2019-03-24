#!/usr/bin/python2
# -*- coding: utf-8 -*-
"""alias-manager.py
Parses a mail file, extracts information from (from, to, cc, resent_to, and resent_cc)
updates and mantains the extracted information in the given alias file.

Usage:
  alias-manager.py [-p] [-l] --file=<aliasFile> [<mailFilePath>]

Arguments:
    <aliasFile>     Path to the alias file to be maintained

Options:
    mailFilePath    Path to the mail file to read
    -p              Print outs the message, this is useful when used within the display filter
                    in mmutt

    -l              export aliases and calls rofi for selecting an email, the selected email will be printed
"""

from email.parser import Parser
from email.utils import getaddresses
from email.header import decode_header
from docopt import docopt           # sudo -H pip install docop
import os
import sys
import tempfile
import shutil
import subprocess
from operator import itemgetter
from rofi import Rofi


def parsBlackList(blackListFilePath):
    blackList = []
    with open(os.path.expanduser(blackListFilePath), "rb") as blackListFile:
        for line in blackListFile:
            line = line.strip('\n')
            if line != '' and line[0] != '#':
                blackList.append(line)
    return blackList


def merge_existing(existing, new):
    (eAlias, eName, eEmail) = itemgetter('alias', 'name', 'email')(existing)
    (nAlias, nName, nEmail) = itemgetter('alias', 'name', 'email')(new)
    nAlias = nAlias.strip()
    nName = nName.strip()
    if nAlias != '':
        eAlias = nAlias
    if nName != '':
        eName = nName
    existing['alias'] = eAlias
    existing['name'] = eName
    return existing


def getAliasFromEmail(email):
    email = email.strip('>').strip('<')
    sp1 = email.split('@')
    sp2 = sp1[1].split('.')
    del sp2[-1]
    return "-".join([sp1[0].replace('.', '-'), "-".join(sp2)])


def parsAliasFile(aliasFilePath):
    dicFile = {}
    with open(os.path.expanduser(aliasFilePath), "rb") as aliasFile:
        for line in aliasFile:
            line = line.strip('\n')
            departed = line.split()
            alias = departed[1]
            email = departed[-1].strip('<>')
            lemail = email.lower()

            skip = False
            for item in blackList:
                if lemail.startswith(item):
                    skip = True
                    continue
            if skip:
                continue

            del departed[-1]    # remove email
            del departed[0]     # remove alias keyword
            if(len(departed) > 0):
                del departed[0]     # remove the original alias and the rest should be the name
            name = " ".join(departed)

            if alias == '':
                alias = getAliasFromEmail(lemail)

            val = {'alias': alias, 'name': name, 'email': email}
            if lemail in dicFile:
                dicFile[lemail] = merge_existing(dicFile[lemail], val)
            else:
                dicFile[lemail] = val
    return dicFile


def writeAliasFile(aliases, aliasFilePath):
    sortedDic = sorted(aliases)
    with open(os.path.expanduser(aliasFilePath), "w") as aliasFile:
        for key in sortedDic:
            val = aliases[key]
            aliasFile.write("alias %s %s <%s>\n" % (val['alias'], val['name'], val['email']))
            # aliasFile.write("alias %-40s %-20s <%s>\n" %
            #                 (val['alias'], val['name'], val['email']))


def addToList(*args):
    list = []
    for item in args:
        if item != None and len(item) > 0 and len(item[0]) > 0:
            list += item
    return list


def parsMail(aliases, aMailPath, printMessage):
    p = Parser()

    if aMailPath == None:
        msg = p.parse(sys.stdin)
    else:
        mailFile = open(aMailPath, "rb")
        msg = p.parse(mailFile)
        mailFile.close()

    froms = msg.get_all('from')
    tos = msg.get_all('to')
    ccs = msg.get_all('cc')
    resent_tos = msg.get_all('resent-to', [])
    resent_ccs = msg.get_all('resent-cc', [])

    all = getaddresses(addToList(froms, tos, ccs, resent_tos, resent_ccs))
    # print froms, tos, css, resent_tos, resent_ccs
    for address in all:
        name, email = address
        lemail = email.lower().strip()

        if lemail == '':
            continue

        decodedTuple = decode_header(name)[0]
        decodedName = decodedTuple[0]
        decodedEncoding = decodedTuple[1]
        if decodedEncoding != None:
            name = decodedName.decode(decodedEncoding).encode('utf8')
        else:
            name = decodedName
        alias = name.strip('.').lower().replace(' ', '-')

        val = {'alias': alias, 'name': name, 'email': email}

        if lemail in aliases:
            aliases[lemail] = merge_existing(aliases[lemail], val)
        else:
            if alias == '':
                alias = getAliasFromEmail(lemail)
            aliases[lemail] = val

    if printMessage:
        print(msg)


def exportToRofi(aliases):
    selection = []
    for alias in aliases.values():
        name = alias['name'].strip()
        if name == '':
            name = alias['alias']
        # print("%s | %s" % (name, alias['email']))
        selection.append("%s | %s" % (name, alias['email']))
    r = Rofi(rofi_args=['-i', '-disable-history', '-levenshtein-sort', '-matching', 'normal', '-e'])
    index, key = r.select("what", selection)
    selected = selection[index].split('|')
    print("%s <%s>" % (selected[0], selected[1].strip()))
# print(getAliasFromEmail('<kurser.syd@folkuniversitetet.se>'))
# sys.exit


args = docopt(__doc__, version='1')
# print(args)
aliasFilePath = args['--file']
mailFilePath = args['<mailFilePath>']
printMessage = args['-p']
aExportToRofi = args['-l']

blackList = parsBlackList('~/.mutt/blacklist_emails.txt')
aliases = parsAliasFile(aliasFilePath)

if aExportToRofi:
    exportToRofi(aliases)
else:
    parsMail(aliases, mailFilePath, printMessage)
    writeAliasFile(aliases, aliasFilePath)
