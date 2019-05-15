<template>

	<div class="alert alert-info" style="margin-bottom: 2px;">
		<div style="margin-bottom: 20px;">
			<Button type="success" @click="onClick('add')">添加</Button>&nbsp;
			<Button type="warning" @click="onClick('update')">修改</Button>&nbsp;
			<Button type="error" @click="onClick('delete')">删除</Button>
		</div>

		<h5>友情提示：商品目录一般分为两层，大类别、小类别。商品目录编码必须唯一。</h5>
		<Divider />
		<Tree ref="catalogTree" :data="data" :load-data="loadData"></Tree>

		<!--对话框-->
		<Modal ref="catalogModal" v-model="show" :title="modalTitle">
			<!--表单-->
			<Form ref="formData" :model="formData" :rules="ruleValidate" :label-width="80">
				<FormItem prop="id" style="display: none;">
					<Input v-model="formData.id"></Input>
				</FormItem>
				<FormItem prop="pid" style="display: none;">
					<Input v-model="formData.pid"></Input>
				</FormItem>
				<FormItem label="父类" prop="pname">
					<Input v-model="formData.pname" readonly="readonly" disabled></Input>
				</FormItem>
				<FormItem label="子类名称" prop="name">
					<Input v-model="formData.name" @on-blur="getCode" placeholder="请输入名称"></Input>
				</FormItem>
				<FormItem label="编码" prop="code">
					<Input v-model="formData.code" placeholder="请输入编码"></Input>
				</FormItem>
				<FormItem label="顺序" prop="order1">
					<InputNumber :max="100" :min="1" v-model="formData.order1"></InputNumber>
				</FormItem>
				<FormItem>
					<Button type="primary" @click="handleSubmit('formData',formType)" style="margin-left: 250px">确 定</Button>
					<Button @click="handleReset('formData')" style="margin-left: 20px">取 消</Button>
				</FormItem>
			</Form>
		</Modal>
	</div>
</template>
<script>
	import {
		getCatalogByPid,
		getCatalogById,
		checkCatalogCode,
		addCatalog,
		updateCatalog,
		deleteCatalogById
	} from '../../api/catalog.js'
	import {
		ConvertPinyin
	} from '../../libs/pinyin.js'

	//记录修改时加载的初始编码值
	let old_catalog_code = '';

	export default {
		data() {
			return {
				data: [{
					id: 0,
					title: '商品分类',
					loading: false,
					children: []
				}],
				//对话框是否显示
				show: false,
				//对话框标题
				modalTitle: '',
				//表单类型
				formType: 'add',
				//表单数据
				formData: {
					id: '',
					pid: '',
					pname: '',
					name: '',
					code: '',
					order1: 1
				},
				//表单数据验证
				ruleValidate: {
					name: [{
							required: true,
							whitespace: true,
							message: '名称不能为空',
							trigger: 'blur'
						},
						{
							pattern: /^\S*$/,
							message: '名称不能包括空字符',
							trigger: 'blur'
						}
					],
					code: [{
							required: true,
							whitespace: true,
							message: '编码不能为空',
							trigger: 'blur'
						},
						{
							pattern: /^\S*$/,
							message: '编码不能包括空字符',
							trigger: 'blur'
						},
						{
							//自定义验证,验证唯一性
							validator(rule, value, callback, source, options) {
								var errors = [];
								//如果修改时，是原来的旧编码，不需要验证唯一性
								if (old_catalog_code == value) {
									callback(errors);
								} else {
									checkCatalogCode(value).then(res => {
											if (res.status.code == 2000) {
												if (res.data) {
													errors.push('编码已被使用');
												}
											}
											callback(errors);
										}).catch(function(error) {
											console.log(error);
										});
									console.log("异步验证code。。。。。。");
								}
							},
							trigger: 'change'
						}
					]
				}
			}
		},
		methods: {
			//相当于刷新吧，目前没找到好方法来刷新tree
			init() {
				this.data = [{
					id: 0,
					title: '商品分类',
					loading: false,
					children: []
				}];
			},

			loadData(item, callback) {
				console.log(item);
				var data = [];
				//根据pid获取商品分类数据
				getCatalogByPid(item.id).then(res => {
					console.log("res : " + res);
					data = res.data;
					console.log(data);
					//由于后端返回数据，都带有children属性，bug,
					//要处理掉parent=false时的children属性和loading属性
					for (let i = 0; i < data.length; i++) {
						if (!data[i]['parent']) {
							console.log(data[i]);
							//删除
							delete data[i]['children'];
							delete data[i]['loading'];
						}
					}
					callback(data);
				}).catch(err => {
					console.log(err)
				});
			},

			//初始化窗口
			initDialog(type) {
				//显示
				this.show = true;
				//初始化对话框，异步刷新dom
				this.$nextTick(function() {
					//引用技术，方便父组件根据名称访问子组件
					console.log(this.$refs.catalogModal);
					//隐藏底部对话框
					this.$refs["catalogModal"].footerHide = true;
				});
				if (type == 'add') {
					//弹出添加商品分类的界面
					this.modalTitle = '添加商品分类';
					this.formType = 'add';
				} else if (type == 'update') {
					this.modalTitle = '修改商品分类';
					this.formType = 'update';
				}
			},

			//按钮单击事件回调
			onClick(type) {
				//判断是否选择了节点
				var nodes = this.$refs.catalogTree.getSelectedNodes();
				if (nodes.length == 0) {
					this.$Message.error('您没有选择节点');
				} else {
					//判断选择了什么按钮
					if (type == 'add') {
						//初始化表单数据
						this.formData.pid = nodes[0].id;
						this.formData.pname = nodes[0].title;
						this.formData.code = '';
						this.formData.id = '';
						this.formData.name = '';
						this.formData.order1 = '1';
						this.initDialog(type);
					} else if (type == 'update') {
						let node_id = nodes[0].id;
						//根节点不能修改
						if (node_id == 0) {
							this.$Message.error('不能修改根节点!');
							return;
						}
						//根据id获取数据
						var cat = {};
						//根据id获取商品分类数据
						getCatalogById(nodes[0].id).then(res => {
							cat = res.data;
							this.formData.id = cat.id;
							this.formData.pid = cat.pid;
							this.formData.pname = cat.pname;
							this.formData.code = cat.code;
							this.formData.name = cat.name;
							this.formData.order1 = cat.order1;
							this.initDialog(type);
							//初始化旧的编码
							old_catalog_code = cat.code;
						}).catch(err => {
							console.log(err)
						});
					} else if (type == 'delete') {
						let node_id = nodes[0].id;
						//根节点不能被删除
						if (node_id == 0) {
							this.$Message.error('不能删除根节点!');

						} else {
							//确认删除
							this.$Modal.confirm({
								title: '删除提醒',
								content: '<p>您确定要删除该【' + nodes[0].title + '】分类吗？</p>',
								onOk: () => {
									//根据id删除类型
									deleteCatalogById(node_id).then(res => {
										if (res.status.code == 2000) {
											this.init();
											this.$Message.success('删除分类成功!');
										} else {
											this.$Message.error('删除分类失败!');
										}
									}).catch(err => {
										console.log(err);
									});
								}
							});
						}
					}
				}
			},
			//生成编码
			getCode() {
				var code = ConvertPinyin(this.formData.name);
				this.formData.code = code;
			},
			//提交表单
			handleSubmit(name) {
				this.$refs[name].validate((valid) => {
					if (valid) {
						if (this.formType == 'add') {
							//添加分类
							addCatalog({
									pid: this.formData.pid,
									name: this.formData.name,
									order1: this.formData.order1,
									code: this.formData.code,
									parent:0
								})
								.then(res => {
									if (res.status.code == 2000) {
										this.init();
										this.$Message.success('添加分类成功!');
									} else {
										this.$Message.error('添加分类失败!');
									}
								})
								.catch(function(error) {
									console.log(error);
								});
						} else if (this.formType == 'update') {
							//修改分类
							updateCatalog({
									id: this.formData.id,
									name: this.formData.name,
									order1: this.formData.order1,
									code: this.formData.code
								})
								.then(res => {
									if (res.status.code == 2000) {
										this.init();
										this.$Message.success('修改分类成功!');
									} else {
										this.$Message.error('修改分类失败!');
									}
								})
								.catch(function(error) {
									console.log(error);
								});
						}

					} else {
						this.$Message.error('表单数据不合法!');
					}
				})
			},
			//重置表单
			handleReset(name) {
				//this.$refs[name].resetFields();
				//全局关闭对话框方法，好像不灵哎！
				//this.$Modal.remove();
				this.show = false;
			}
		},
		mounted: function() {
			//this.init();
		}
	}
</script>
