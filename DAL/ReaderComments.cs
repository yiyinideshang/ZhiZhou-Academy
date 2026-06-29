using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using Maticsoft.DBUtility;//Please add references
namespace Maticsoft.DAL
{
	/// <summary>
	/// 数据访问类:ReaderComments
	/// </summary>
	public partial class ReaderComments
	{
		public ReaderComments()
		{}
		#region  BasicMethod

		/// <summary>
		/// 得到最大ID
		/// </summary>
		public int GetMaxId()
		{
		return DbHelperSQL.GetMaxID("Id", "ReaderComments"); 
		}

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(int Id)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from ReaderComments");
			strSql.Append(" where Id=@Id");
			SqlParameter[] parameters = {
					new SqlParameter("@Id", SqlDbType.Int,4)
			};
			parameters[0].Value = Id;

			return DbHelperSQL.Exists(strSql.ToString(),parameters);
		}


		/// <summary>
		/// 增加一条数据
		/// </summary>
		public int Add(Maticsoft.Model.ReaderComments model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into ReaderComments(");
			strSql.Append("CourseId,UserId,Title,Comment,Date,IsShow,beiyong)");
			strSql.Append(" values (");
			strSql.Append("@CourseId,@UserId,@Title,@Comment,@Date,@IsShow,@beiyong)");
			strSql.Append(";select @@IDENTITY");
			SqlParameter[] parameters = {
					new SqlParameter("@CourseId", SqlDbType.Int,4),
					new SqlParameter("@UserId", SqlDbType.Int,4),
					new SqlParameter("@Title", SqlDbType.NVarChar,100),
					new SqlParameter("@Comment", SqlDbType.NVarChar,300),
					new SqlParameter("@Date", SqlDbType.DateTime),
					new SqlParameter("@IsShow", SqlDbType.Int,4),
					new SqlParameter("@beiyong", SqlDbType.NVarChar,-1)};
			parameters[0].Value = model.CourseId;
			parameters[1].Value = model.UserId;
			parameters[2].Value = model.Title;
			parameters[3].Value = model.Comment;
			parameters[4].Value = model.Date;
			parameters[5].Value = model.IsShow;
			parameters[6].Value = model.beiyong;

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
		public bool Update(Maticsoft.Model.ReaderComments model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update ReaderComments set ");
			strSql.Append("CourseId=@CourseId,");
			strSql.Append("UserId=@UserId,");
			strSql.Append("Title=@Title,");
			strSql.Append("Comment=@Comment,");
			strSql.Append("Date=@Date,");
			strSql.Append("IsShow=@IsShow,");
			strSql.Append("beiyong=@beiyong");
			strSql.Append(" where Id=@Id");
			SqlParameter[] parameters = {
					new SqlParameter("@CourseId", SqlDbType.Int,4),
					new SqlParameter("@UserId", SqlDbType.Int,4),
					new SqlParameter("@Title", SqlDbType.NVarChar,100),
					new SqlParameter("@Comment", SqlDbType.NVarChar,300),
					new SqlParameter("@Date", SqlDbType.DateTime),
					new SqlParameter("@IsShow", SqlDbType.Int,4),
					new SqlParameter("@beiyong", SqlDbType.NVarChar,-1),
					new SqlParameter("@Id", SqlDbType.Int,4)};
			parameters[0].Value = model.CourseId;
			parameters[1].Value = model.UserId;
			parameters[2].Value = model.Title;
			parameters[3].Value = model.Comment;
			parameters[4].Value = model.Date;
			parameters[5].Value = model.IsShow;
			parameters[6].Value = model.beiyong;
			parameters[7].Value = model.Id;

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
			strSql.Append("delete from ReaderComments ");
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
			strSql.Append("delete from ReaderComments ");
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
		public Maticsoft.Model.ReaderComments GetModel(int Id)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 Id,CourseId,UserId,Title,Comment,Date,IsShow,beiyong from ReaderComments ");
			strSql.Append(" where Id=@Id");
			SqlParameter[] parameters = {
					new SqlParameter("@Id", SqlDbType.Int,4)
			};
			parameters[0].Value = Id;

			Maticsoft.Model.ReaderComments model=new Maticsoft.Model.ReaderComments();
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
		public Maticsoft.Model.ReaderComments DataRowToModel(DataRow row)
		{
			Maticsoft.Model.ReaderComments model=new Maticsoft.Model.ReaderComments();
			if (row != null)
			{
				if(row["Id"]!=null && row["Id"].ToString()!="")
				{
					model.Id=int.Parse(row["Id"].ToString());
				}
				if(row["CourseId"]!=null && row["CourseId"].ToString()!="")
				{
					model.CourseId=int.Parse(row["CourseId"].ToString());
				}
				if(row["UserId"]!=null && row["UserId"].ToString()!="")
				{
					model.UserId=int.Parse(row["UserId"].ToString());
				}
				if(row["Title"]!=null)
				{
					model.Title=row["Title"].ToString();
				}
				if(row["Comment"]!=null)
				{
					model.Comment=row["Comment"].ToString();
				}
				if(row["Date"]!=null && row["Date"].ToString()!="")
				{
					model.Date=DateTime.Parse(row["Date"].ToString());
				}
				if(row["IsShow"]!=null && row["IsShow"].ToString()!="")
				{
					model.IsShow=int.Parse(row["IsShow"].ToString());
				}
				if(row["beiyong"]!=null)
				{
					model.beiyong=row["beiyong"].ToString();
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
			strSql.Append("select Id,CourseId,UserId,Title,Comment,Date,IsShow,beiyong ");
			strSql.Append(" FROM ReaderComments ");
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
			strSql.Append(" Id,CourseId,UserId,Title,Comment,Date,IsShow,beiyong ");
			strSql.Append(" FROM ReaderComments ");
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
			strSql.Append("select count(1) FROM ReaderComments ");
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
			strSql.Append(")AS Row, T.*  from ReaderComments T ");
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
			parameters[0].Value = "ReaderComments";
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

