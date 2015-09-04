test:	reorder-chat-tiers.pl test.cha test-reordered.cha
	./reorder-chat-tiers.pl test.cha > test-result.cha \
		&& diff test-result.cha test-reordered.cha \
		&& rm test-result.cha

.PHONY:
	test
