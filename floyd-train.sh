#!/bin/bash


RUNTIME=$(expr 60 \* 60 \* 4)
COMMIT=$(git --no-pager log --pretty=format:'%h' -n 1)

floyd run \
	--message "$COMMIT SSC curriculum long training" \
	--gpu \
	--env tensorflow-1.10 \
	--data davidmack/datasets/mac-graph-ssc:/input \
	"python -m macgraph.train \
		--dataset StationShortestCount \
		--input-dir /input \
		--model-dir /output \
		--enable-comet \
		--enable-floyd \
		--max-decode-iterations 8 \
		--train-max-steps 30 \
		--tag upto_8 \
		--tag iter_8 \
		--tag curriculum \
		--enable-curriculum \
		--filter-output-class 8 \
		--filter-output-class 7 \
		--filter-output-class 6 \
		--filter-output-class 5 \
		--filter-output-class 4 \
		--filter-output-class 3 \
		--filter-output-class 2 \
		--filter-output-class 1 \
		--filter-output-class 0 \
		--disable-control-cell \
		--disable-read-cell \
		--disable-memory-cell \
		--disable-input-bilstm \
		--enable-embed-const-eye \
		--eval-every 90 \
		--mp-state-width 1 \
		--disable-mp-gru \
		--input-width 128 \
		--embed-width 128 \
		--learning-rate 0.1 \
		--fast"
