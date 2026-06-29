using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using Maticsoft.DBUtility;//Please add references
namespace Maticsoft.DAL
{
	/// <summary>
	/// 数据访问类:Users
	/// </summary>
	public partial class Users
	{
		public Users()
		{}
		#region  BasicMethod

		/// <summary>
		/// 得到最大ID
		/// </summary>
		public int GetMaxId()
		{
			return DbHelperSQL.GetMaxID("Id", "Users"); 
		}

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(int Id)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from Users");
			strSql.Append(" where Id=@Id");
			SqlParameter[] parameters = {
					new SqlParameter("@Id", SqlDbType.Int,4)
			};
			parameters[0].Value = Id;

			return DbHelperSQL.Exists(strSql.ToString(),parameters);
		}
        public bool Exists(string LoginId,string LoginPwd)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(1) from Users");
            strSql.Append(" where LoginId=@LoginId and LoginPwd=@LoginPwd");
            SqlParameter[] parameters = {
					new SqlParameter("@LoginId", SqlDbType.NVarChar),
                    new SqlParameter("@LoginPwd", SqlDbType.NVarChar),

			};
            parameters[0].Value = LoginId;
            parameters[1].Value = LoginPwd;

            return DbHelperSQL.Exists(strSql.ToString(), parameters);
        }

        public bool Exists(string LoginId)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(1) from Users");
            strSql.Append(" where LoginId=@LoginId");
            SqlParameter[] parameters = {
					new SqlParameter("@LoginId", SqlDbType.NVarChar)
			};
            parameters[0].Value = LoginId;

            return DbHelperSQL.Exists(strSql.ToString(), parameters);
        }

		/// <summary>
		/// 增加一条数据
		/// </summary>
		public int Add(Maticsoft.Model.Users model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into Users(");
			strSql.Append("LoginId,LoginPwd,UserRoleld,Name,Adress,Phone,Mail,Gender,mobile,photo,IsShow)");
			strSql.Append(" values (");
			strSql.Append("@LoginId,@LoginPwd,@UserRoleld,@Name,@Adress,@Phone,@Mail,@Gender,@mobile,@photo,@IsShow)");
			strSql.Append(";select @@IDENTITY");
			SqlParameter[] parameters = {
					new SqlParameter("@LoginId", SqlDbType.NVarChar,50),
					new SqlParameter("@LoginPwd", SqlDbType.NVarChar,50),
					new SqlParameter("@UserRoleld", SqlDbType.Int,4),
					new SqlParameter("@Name", SqlDbType.NVarChar,50),
					new SqlParameter("@Adress", SqlDbType.NVarChar,200),
					new SqlParameter("@Phone", SqlDbType.NVarChar,100),
					new SqlParameter("@Mail", SqlDbType.NVarChar,100),
					new SqlParameter("@Gender", SqlDbType.Int,4),
					new SqlParameter("@mobile", SqlDbType.NVarChar,50),
					new SqlParameter("@photo", SqlDbType.NVarChar,-1),
					new SqlParameter("@IsShow", SqlDbType.Int,4)};
			parameters[0].Value = model.LoginId;
			parameters[1].Value = model.LoginPwd;
			parameters[2].Value = model.UserRoleld;
			parameters[3].Value = model.Name;
			parameters[4].Value = model.Adress;
			parameters[5].Value = model.Phone;
			parameters[6].Value = model.Mail;
			parameters[7].Value = model.Gender;
			parameters[8].Value = model.mobile;
			parameters[9].Value = model.photo;
			parameters[10].Value = model.IsShow;

			object obj = DbHelperSQL.GetSingle(strSql.ToString(),parameters);
			if (obj == null)
			{
				return 0;
			}
			else
			{
				return Convert.ToInt32(obj);
			}
		}
		/// <summary>
		/// 更新一条数据
		/// </summary>
		public bool Update(Maticsoft.Model.Users model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update Users set ");
			strSql.Append("LoginId=@LoginId,");
			strSql.Append("LoginPwd=@LoginPwd,");
			strSql.Append("UserRoleld=@UserRoleld,");
			strSql.Append("Name=@Name,");
			strSql.Append("Adress=@Adress,");
			strSql.Append("Phone=@Phone,");
			strSql.Append("Mail=@Mail,");
			strSql.Append("Gender=@Gender,");
			strSql.Append("mobile=@mobile,");
			strSql.Append("photo=@photo,");
			strSql.Append("IsShow=@IsShow");
			strSql.Append(" where Id=@Id");
			SqlParameter[] parameters = {
					new SqlParameter("@LoginId", SqlDbType.NVarChar,50),
					new SqlParameter("@LoginPwd", SqlDbType.NVarChar,50),
					new SqlParameter("@UserRoleld", SqlDbType.Int,4),
					new SqlParameter("@Name", SqlDbType.NVarChar,50),
					new SqlParameter("@Adress", SqlDbType.NVarChar,200),
					new SqlParameter("@Phone", SqlDbType.NVarChar,100),
					new SqlParameter("@Mail", SqlDbType.NVarChar,100),
					new SqlParameter("@Gender", SqlDbType.Int,4),
					new SqlParameter("@mobile", SqlDbType.NVarChar,50),
					new SqlParameter("@photo", SqlDbType.NVarChar,-1),
					new SqlParameter("@IsShow", SqlDbType.Int,4),
					new SqlParameter("@Id", SqlDbType.Int,4)};
			parameters[0].Value = model.LoginId;
			parameters[1].Value = model.LoginPwd;
			parameters[2].Value = model.UserRoleld;
			parameters[3].Value = model.Name;
			parameters[4].Value = model.Adress;
			parameters[5].Value = model.Phone;
			parameters[6].Value = model.Mail;
			parameters[7].Value = model.Gender;
			parameters[8].Value = model.mobile;
			parameters[9].Value = model.photo;
			parameters[10].Value = model.IsShow;
			parameters[11].Value = model.Id;

			int rows=DbHelperSQL.ExecuteSql(strSql.ToString(),parameters);
			if (rows > 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

		/// <summary>
		/// 删除一条数据
		/// </summary>
		public bool Delete(int Id)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from Users ");
			strSql.Append(" where Id=@Id");
			SqlParameter[] parameters = {
					new SqlParameter("@Id", SqlDbType.Int,4)
			};
			parameters[0].Value = Id;

			int rows=DbHelperSQL.ExecuteSql(strSql.ToString(),parameters);
			if (rows > 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		/// <summary>
		/// 批量删除数据
		/// </summary>
		public bool DeleteList(string Idlist )
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from Users ");
			strSql.Append(" where Id in ("+Idlist + ")  ");
			int rows=DbHelperSQL.ExecuteSql(strSql.ToString());
			if (rows > 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}


		/// <summary>
		/// 得到一个对象实体
		/// </summary>
		public Maticsoft.Model.Users GetModel(int Id)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 Id,LoginId,LoginPwd,UserRoleld,Name,Adress,Phone,Mail,Gender,mobile,photo,IsShow from Users ");
			strSql.Append(" where Id=@Id");
			SqlParameter[] parameters = {
					new SqlParameter("@Id", SqlDbType.Int,4)
			};
			parameters[0].Value = Id;

			Maticsoft.Model.Users model=new Maticsoft.Model.Users();
			DataSet ds=DbHelperSQL.Query(strSql.ToString(),parameters);
			if(ds.Tables[0].Rows.Count>0)
			{
				return DataRowToModel(ds.Tables[0].Rows[0]);
			}
			else
			{
				return null;
			}
		}


		/// <summary>
		/// 得到一个对象实体
		/// </summary>
		public Maticsoft.Model.Users DataRowToModel(DataRow row)
		{
			Maticsoft.Model.Users model=new Maticsoft.Model.Users();
			if (row != null)
			{
				if(row["Id"]!=null && row["Id"].ToString()!="")
				{
					model.Id=int.Parse(row["Id"].ToString());
				}
				if(row["LoginId"]!=null)
				{
					model.LoginId=row["LoginId"].ToString();
				}
				if(row["LoginPwd"]!=null)
				{
					model.LoginPwd=row["LoginPwd"].ToString();
				}
				if(row["UserRoleld"]!=null && row["UserRoleld"].ToString()!="")
				{
					model.UserRoleld=int.Parse(row["UserRoleld"].ToString());
				}
				if(row["Name"]!=null)
				{
					model.Name=row["Name"].ToString();
				}
				if(row["Adress"]!=null)
				{
					model.Adress=row["Adress"].ToString();
				}
				if(row["Phone"]!=null)
				{
					model.Phone=row["Phone"].ToString();
				}
				if(row["Mail"]!=null)
				{
					model.Mail=row["Mail"].ToString();
				}
				if(row["Gender"]!=null && row["Gender"].ToString()!="")
				{
					model.Gender=int.Parse(row["Gender"].ToString());
				}
				if(row["mobile"]!=null)
				{
					model.mobile=row["mobile"].ToString();
				}
				if(row["photo"]!=null)
				{
					model.photo=row["photo"].ToString();
				}
				if(row["IsShow"]!=null && row["IsShow"].ToString()!="")
				{
					model.IsShow=int.Parse(row["IsShow"].ToString());
				}
			}
			return model;
		}

		/// <summary>
		/// 获得数据列表
		/// </summary>
		public DataSet GetList(string strWhere)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select Id,LoginId,LoginPwd,UserRoleld,Name,Adress,Phone,Mail,Gender,mobile,photo,IsShow ");
			strSql.Append(" FROM Users ");
			if(strWhere.Trim()!="")
			{
				strSql.Append(" where "+strWhere);
			}
			return DbHelperSQL.Query(strSql.ToString());
		}

		/// <summary>
		/// 获得前几行数据
		/// </summary>
		public DataSet GetList(int Top,string strWhere,string filedOrder)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select ");
			if(Top>0)
			{
				strSql.Append(" top "+Top.ToString());
			}
			strSql.Append(" Id,LoginId,LoginPwd,UserRoleld,Name,Adress,Phone,Mail,Gender,mobile,photo,IsShow ");
			strSql.Append(" FROM Users ");
			if(strWhere.Trim()!="")
			{
				strSql.Append(" where "+strWhere);
			}
			strSql.Append(" order by " + filedOrder);
			return DbHelperSQL.Query(strSql.ToString());
		}

		/// <summary>
		/// 获取记录总数
		/// </summary>
		public int GetRecordCount(string strWhere)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) FROM Users ");
			if(strWhere.Trim()!="")
			{
				strSql.Append(" where "+strWhere);
			}
			object obj = DbHelperSQL.GetSingle(strSql.ToString());
			if (obj == null)
			{
				return 0;
			}
			else
			{
				return Convert.ToInt32(obj);
			}
		}
		/// <summary>
		/// 分页获取数据列表
		/// </summary>
		public DataSet GetListByPage(string strWhere, string orderby, int startIndex, int endIndex)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("SELECT * FROM ( ");
			strSql.Append(" SELECT ROW_NUMBER() OVER (");
			if (!string.IsNullOrEmpty(orderby.Trim()))
			{
				strSql.Append("order by T." + orderby );
			}
			else
			{
				strSql.Append("order by T.Id desc");
			}
			strSql.Append(")AS Row, T.*  from Users T ");
			if (!string.IsNullOrEmpty(strWhere.Trim()))
			{
				strSql.Append(" WHERE " + strWhere);
			}
			strSql.Append(" ) TT");
			strSql.AppendFormat(" WHERE TT.Row between {0} and {1}", startIndex, endIndex);
			return DbHelperSQL.Query(strSql.ToString());
		}

		/*
		/// <summary>
		/// 分页获取数据列表
		/// </summary>
		public DataSet GetList(int PageSize,int PageIndex,string strWhere)
		{
			SqlParameter[] parameters = {
					new SqlParameter("@tblName", SqlDbType.VarChar, 255),
					new SqlParameter("@fldName", SqlDbType.VarChar, 255),
					new SqlParameter("@PageSize", SqlDbType.Int),
					new SqlParameter("@PageIndex", SqlDbType.Int),
					new SqlParameter("@IsReCount", SqlDbType.Bit),
					new SqlParameter("@OrderType", SqlDbType.Bit),
					new SqlParameter("@strWhere", SqlDbType.VarChar,1000),
					};
			parameters[0].Value = "Users";
			parameters[1].Value = "Id";
			parameters[2].Value = PageSize;
			parameters[3].Value = PageIndex;
			parameters[4].Value = 0;
			parameters[5].Value = 0;
			parameters[6].Value = strWhere;	
			return DbHelperSQL.RunProcedure("UP_GetRecordByPage",parameters,"ds");
		}*/

		#endregion  BasicMethod
		#region  ExtensionMethod

		#endregion  ExtensionMethod
	}
}
