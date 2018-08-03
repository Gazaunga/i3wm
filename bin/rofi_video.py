#!/usr/bin/env python
import subprocess
import os

def update_bookmark(dir,number):
    with open(dir+"/.bookmark",'w') as f:
        f.write(number)

def read_bookmark(dir):
    if not os.path.isfile(dir+"/.bookmark"):
        update_bookmark(dir,"1")
        return "1"
    with open(dir+"/.bookmark","r") as f:
        return(f.readlines()[0].replace("\n",""))

def call_rofi(entries,command):
    proc = subprocess.Popen(command,
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE)
    for e in entries:
        proc.stdin.write((e+"\n").encode('utf-8'))
    proc.stdin.close()
    answer = proc.stdout.read().decode('utf-8')
    return answer.replace("\n","")

def get_chapter(file):
    name,number = file.replace(".mkv","").split(" - ")
    return int(number)

def get_files(dir):
    chapters = [file for file in os.listdir(dir) if file.endswith(".mkv")]
    chapters.sort(key=lambda file: get_chapter(file))
    return chapters

def get_folders(dir):
    return [file for file in os.listdir(dir) if os.path.isdir(dir+"/"+file)]


def choose_folder(dir):
    command = ['rofi','-dmenu','-lines','4','-i','-p',"Anime"]
    folders = get_folders(dir)
    folder = call_rofi(folders,command)
    return folder if folder in folders else None

def choose_chapter(dir):
    command = ['rofi','-dmenu','-lines','4','-i','-p',"Chapter\nLast Chapter "+read_bookmark(dir)]
    chapters = get_files(dir)
    chapter = call_rofi(chapters,command)
    return chapter if chapter in chapters else None

dir = "/your/video/folder"
folder = choose_folder(dir)
if folder != None:
    chapter = choose_chapter(dir+"/"+folder)
    if chapter != None:
        chapter_dir = dir+"/"+folder+"/"+chapter
        chapter_number = str(get_chapter(chapter_dir))
        update_bookmark(dir+"/"+folder,chapter_number)
        subprocess.Popen(['mpv',chapter_dir])
