#!/usr/bin/env bash

train_cmd="utils/run.pl"
decode_cmd="utils/run.pl"



train_yesno=train_yesno
test_base_name=test_yesno
#utils/fix_data_dir.sh data/test_yesno


python data_prep_decode.py
# Feature extraction
for x in test_yesno; do 
 utils/fix_data_dir.sh data/$x
 steps/make_mfcc.sh --nj 4 data/$x exp_1/log/make_mfcc/$x 
 steps/compute_cmvn_stats.sh data/$x exp_1/log/make_mfcc/$x
 
done


# Graph compilation  
utils/mkgraph.sh --mono data/lang1 exp_1/mono0a exp_1/mono0a/graph


# Decoding
steps/decode.sh --nj 1 --cmd "$decode_cmd" \
    exp_1/mono0a/graph data/test_yesno exp_1/mono0a/decode4_test_yesno

python reading.py

