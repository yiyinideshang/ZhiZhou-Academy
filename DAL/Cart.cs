using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using Maticsoft.DBUtility;
namespace Maticsoft.DAL
{
	public partial class Cart
	{
		public Cart()
		{}
		#region  BasicMethod

		public int GetMaxId()
		{
			return DbHelperSQL.GetMaxID("Id", "Cart");
		}

		public bool Exists(int Id)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from Cart");
			strSql.Append(" where Id=@Id");
			SqlParameter[] parameters = {
					new SqlParameter("@Id", SqlDbType.Int,4)
			};
			parameters[0].Value = Id;
			return DbHelperSQL.Exists(strSql.ToString(),parameters);
		}

		public int Add(Maticsoft.Model.Cart model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into Cart(");
			strSql.Append("UserId,CourseId)");
			strSql.Append(" values (");
			strSql.Append("@UserId,@CourseId)");
			strSql.Append(";select @@IDENTITY");
			SqlParameter[] parameters = {
					new SqlParameter("@UserId", SqlDbType.Int,4),
					new SqlParameter("@CourseId", SqlDbType.Int,4)
			};
			parameters[0].Value = model.UserId;
			parameters[1].Value = model.CourseId;

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

		public bool Update(Maticsoft.Model.Cart model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update Cart set ");
			strSql.Append("UserId=@UserId,");
			strSql.Append("CourseId=@CourseId");
			strSql.Append(" where Id=@Id");
			SqlParameter[] parameters = {
					new SqlParameter("@UserId", SqlDbType.Int,4),
					new SqlParameter("@CourseId", SqlDbType.Int,4),
					new SqlParameter("@Id", SqlDbType.Int,4)
			};
			parameters[0].Value = model.UserId;
			parameters[1].Value = model.CourseId;
			parameters[2].Value = model.Id;

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

		public bool Delete(int Id)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from Cart ");
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

		public bool DeleteList(string Idlist )
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("delete from Cart ");
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

		public Maticsoft.Model.Cart GetModel(int Id)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 Id,UserId,CourseId,AddTime from Cart ");
			strSql.Append(" where Id=@Id");
			SqlParameter[] parameters = {
					new SqlParameter("@Id", SqlDbType.Int,4)
			};
			parameters[0].Value = Id;

			Maticsoft.Model.Cart model=new Maticsoft.Model.Cart();
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

		public Maticsoft.Model.Cart DataRowToModel(DataRow row)
		{
			Maticsoft.Model.Cart model=new Maticsoft.Model.Cart();
			if (row != null)
			{
				if(row["Id"]!=null && row["Id"].ToString()!="")
				{
					model.Id=int.Parse(row["Id"].ToString());
				}
				if(row["UserId"]!=null && row["UserId"].ToString()!="")
				{
					model.UserId=int.Parse(row["UserId"].ToString());
				}
				if(row["CourseId"]!=null && row["CourseId"].ToString()!="")
				{
					model.CourseId=int.Parse(row["CourseId"].ToString());
				}
				if(row["AddTime"]!=null && row["AddTime"].ToString()!="")
				{
					model.AddTime=DateTime.Parse(row["AddTime"].ToString());
				}
			}
			return model;
		}

		public DataSet GetList(string strWhere)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select Id,UserId,CourseId,AddTime ");
			strSql.Append(" FROM Cart ");
			if(strWhere.Trim()!="")
			{
				strSql.Append(" where "+strWhere);
			}
			return DbHelperSQL.Query(strSql.ToString());
		}

		public DataSet GetList(int Top,string strWhere,string filedOrder)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select ");
			if(Top>0)
			{
				strSql.Append(" top "+Top.ToString());
			}
			strSql.Append(" Id,UserId,CourseId,AddTime ");
			strSql.Append(" FROM Cart ");
			if(strWhere.Trim()!="")
			{
				strSql.Append(" where "+strWhere);
			}
			strSql.Append(" order by " + filedOrder);
			return DbHelperSQL.Query(strSql.ToString());
		}

		public int GetRecordCount(string strWhere)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) FROM Cart ");
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
			strSql.Append(")AS Row, T.*  from Cart T ");
			if (!string.IsNullOrEmpty(strWhere.Trim()))
			{
				strSql.Append(" WHERE " + strWhere);
			}
			strSql.Append(" ) TT");
			strSql.AppendFormat(" WHERE TT.Row between {0} and {1}", startIndex, endIndex);
			return DbHelperSQL.Query(strSql.ToString());
		}

		#endregion  BasicMethod
		#region  ExtensionMethod
		#endregion  ExtensionMethod
	}
}
