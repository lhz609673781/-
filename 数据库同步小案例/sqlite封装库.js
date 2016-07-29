//创建一个数据库操作对象，并指定数据库名和数据库大小，单位（M）
function SqlHelper(dbname,size){
	this.dbname=dbname;
	this.size=size;
	this.init();
}

SqlHelper.propertype={
	init:function(){//对这个数据库进行初始化
		if(!this.db){
			if(window.openDatabase){//判断该浏览器是否支持    因为size是以M为单位
				this.db=openDatabase(this.dbname,1.0,"database",this.size*1024*1024);
			}else{
				return false;
			}
		}
	},





/*
	执行增、删、改的sql语句
	sql:delete from XXX
	replace:是占位符？的值
*/
	exesql:function(sql,replace){
		if(replace){//如果有值则执行
			this.db.transaction(function(tx){
				tx.executeSql(sql,replace);
			})
		}else{
			this.db.transaction(function(tx){
				tx.executeSql(sql,[]);
			})
		}
	},



/*创建一张表
	tableName：表名
	fields：表字段信息，是一段json格式的数据  如{"id":"int primary key","uname":"text"}
*/

	createTable:function(tableName,fields){
		var sql="CREATE TABLE IF NOT EXISTS"+tableName+"(";
		for(i in fields){//循环里面的每一个键
			if(fields.hasOwnProperty(i)){
				sql+=i+" "+fields[i]+",";
			}
		}
		sql=sql.substr(0,sql.length-1);//截取字符串，可删除最后一个,
		sql+=")";
		this.exesql(sql);//再通过封装的exesql函数运行此语句
	},



/*
	封装查询
	tablenName:表名
	selectFields：要查询的字段（id,name）查询所有用*
	whereStr：where语句条件 参数用？代替（id=? and name=?）
	whereParams:替代？的一个数组
	callback  对select返回数据的操作的回调函数
*/
	select:function(tableName,selectFields,whereStr,whereParams,callback){
		//select * from 表名
		var sql="SELECT" +selectFields+"FROM"+tableName;
		//如果有where 语句则执行下条
		if(typeof(whereStr)!="undefined" && typeof(whereParams)!="undefined"&&whereStr!=""){
			sql+="where"+whereStr;
		}

		this.db.transaction(function(tx){
			//查询语句    ？的参数数组     回调函数
			tx.executeSql(sql,whereParams,function(tx,results){
				if(results.rows.length<1){
					if(typeof(callback)=='function'){
						callback(false);//真正的回调函数调用，若不是一个function则返回false
					}
				}else{
					if(typeof(callback)=='function'){
						//如果是一个函数则调用返回结果的集合
						callback(results.rows)
					}
				}
			})
		})
	}
}