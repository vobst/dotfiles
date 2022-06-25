#!/usr/bin/env bash

# no whitespaces in filenames or on path

SRC_HOST=ab
DST_HOST=ms

SRC_DIR="/tmp/test.d"
DST_DIR="/tmp/test.d"

SCP_FLAGS="-3 -C -l 10000"

SRC_FILES=$(ssh $SRC_HOST ls $SRC_DIR)
DST_FILES=$(ssh $DST_HOST ls $DST_DIR)

function vlog {
  echo "[ $0 ] $1"
}

function is_new {
  vlog "Called $FUNCNAME $1"
  for file in $DST_FILES;
  do
    if [[ $file == $1 ]]
    then
      vlog "File $1 is already backed up."
      return 1
    fi
  done
  vlog "File $1 is new."
  return 0
}

function sec_backup {
  vlog "Called $FUNCNAME $1"
  SRC_PATH=$SRC_DIR/$1
  DST_PATH=$DST_DIR/$1
  transfer_file $SRC_PATH $DST_PATH
  check_file_integrity $SRC_PATH $DST_PATH
}

function transfer_file {
  vlog "Called $FUNCNAME $1 $2"
  vlog "Starting transfer from $SRC_HOST:$1 to $DST_HOST:$2"
  if scp $SCP_FLAGS $SRC_HOST:$1 $DST_HOST:$2;
  then
    vlog "Successfully transferred file $1"
  else
    vlog "Transfer of file $1 failed. Aborting."
    exit 1
  fi
}

function check_file_integrity {
  vlog "Called $FUNCNAME $1 $2"
  vlog "Verifying file integrity"
  SRC_HASH=$(ssh $SRC_HOST openssl md5 $1 | grep -oE '[a-f0-9]+$')
  DST_HASH=$(ssh $DST_HOST openssl md5 $2 | grep -oE '[a-f0-9]+$')
  if [[ $SRC_HASH == $DST_HASH ]]
  then
    vlog "Hashes match"
  else
    vlog "Hashes $SRC_HASH and $DST_HASH do not match. Aborting"
    exit 1
  fi
}

function do_backup {
  vlog "Called $FUNCNAME"
  vlog "Starting backup of $SRC_HOST:$SRC_DIR to $DST_HOST:$DST_DIR"
  for file in $SRC_FILES;
  do
    CUR_FILE=$file
    if is_new $CUR_FILE;
    then
      sec_backup $CUR_FILE
    fi
  done
  vlog "Backup done. Bye."
}

do_backup
