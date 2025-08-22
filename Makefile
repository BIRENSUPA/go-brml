BINDING_DIR := ./brml

pre:
	sed -i '/typedef struct brmlDevice_st\* brmlDevice_t;/c\
typedef struct\
{\
   struct brmlDevice_st* handle;\
} brmlDevice_t;' $(BINDING_DIR)/brml.h




gen: pre
	c-for-go -debug -out ./ $(BINDING_DIR)/brml.yml
	cd $(BINDING_DIR); \
	go tool cgo -godefs types.go > types_gen.go; \
	sed -i 's/Free\tuint64/Freed\tuint64/g' types_gen.go; \
	rm -rf types.go _obj; \
	git checkout brml.h  # 撤销 brml.h 的修改
	

