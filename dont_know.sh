a/compute-mfcc-feats \
    --config=a/configuration.txt \
    scp:data/test_yesno/wav.scp \
    ark,scp:transcriptions/feats.ark,transcriptions/feats.scp

a/add-deltas \
    scp:transcriptions/feats.scp \
    ark:transcriptions/delta-feats.ark

a/gmm-latgen-faster --word-symbol-table=exp_1/mono0a/graph/words.txt \
    exp_1/mono0a/final.mdl \
    exp_1/mono0a/graph/HCLG.fst \
    ark:transcriptions/feats.ark \
    ark,t:transcriptions/lattices.ark

a/lattice-best-path \
    --word-symbol-table=exp_1/mono0a/graph/words.txt \
    ark:transcriptions/lattices.ark \
    ark,t:transcriptions/one-best.tra

utils/int2sym.pl -f 2- \
    exp_1/mono0a/graph/words.txt \
    transcriptions/one-best.tra \
    > transcriptions/one-best-hypothesis.txt