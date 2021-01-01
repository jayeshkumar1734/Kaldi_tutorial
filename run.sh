#!/usr/bin/env bash

train_cmd="utils/run.pl"
decode_cmd="utils/run.pl"



train_yesno=train_yesno
test_base_name=test_yesno
#utils/fix_data_dir.sh data/test_yesno

rm -rf exp_1 

# Data preparation

python data_prep.py

utils/prepare_lang.sh --position-dependent-phones false dict "<SIL>" dict/temp_decode data/lang1
lm/arpa2fst --disambig-symbol="#0" --read-symbol-table=data/lang1/words.txt lm/yesno-unigram.arpabo data/lang1/G.fst

# Feature extraction
for x in train_yesno; do 
 utils/fix_data_dir.sh data/$x
 steps/make_mfcc.sh --nj 4 data/$x exp_1/log/make_mfcc/$x 
 steps/compute_cmvn_stats.sh data/$x exp_1/log/make_mfcc/$x
 
done

# Mono training
steps/train_mono.sh --nj 1 --cmd "$train_cmd" \
  --totgauss 400 \
  data/train_yesno data/lang1 exp_1/mono0a 
  
# Graph compilation  
utils/mkgraph.sh --mono data/lang1 exp_1/mono0a exp_1/mono0a/graph