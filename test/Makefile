#.PHONY:clean all
.SUFFIXES: .erl .beam


#.erl.beam:
#	erlc -W -I ../include $<

RUN_BIN=raga_SUITE raga_node_SUITE

all:$(RUN_BIN)

# 具体过程可以参看静态模式匹配 同时用到 没有后缀的模式规则
# 对每个目标单独定义默认规则
$(RUN_BIN): %: %.erl
    #$(CC) $(CFLAGS)  $< -o $@
	erlc -I ../include $<

clean:
	rm -f *.beam
