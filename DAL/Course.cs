using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using Maticsoft.DBUtility;//Please add references
namespace Maticsoft.DAL
{
	/// <summary>
	/// 数据访问类:Course
	/// </summary>
	public partial class Course
	{
		public Course()
		{}
		#region  BasicMethod

		/// <summary>
		/// 得到最大ID
		/// </summary>
		public int GetMaxId()
		{
		return DbHelperSQL.GetMaxID("Id", "Course"); 
		}

		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(int Id)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select count(1) from Course");
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
		public int Add(Maticsoft.Model.Course model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("insert into Course(");
			strSql.Append("Title,Author,CategoryId,Clicks,PublishDate,Duration,ContentDescription,AurhorDescription,EditorComment,TOC,Registration,IsShow,Price,StartDate,beiyong,IsRecommended)");
			strSql.Append(" values (");
			strSql.Append("@Title,@Author,@CategoryId,@Clicks,@PublishDate,@Duration,@ContentDescription,@AurhorDescription,@EditorComment,@TOC,@Registration,@IsShow,@Price,@StartDate,@beiyong,@IsRecommended)");
			strSql.Append(";select @@IDENTITY");
			SqlParameter[] parameters = {
					new SqlParameter("@Title", SqlDbType.NVarChar,200),
					new SqlParameter("@Author", SqlDbType.NVarChar,200),
					new SqlParameter("@CategoryId", SqlDbType.Int,4),
					new SqlParameter("@Clicks", SqlDbType.Int,4),
					new SqlParameter("@PublishDate", SqlDbType.DateTime),
					new SqlParameter("@Duration", SqlDbType.Int,4),
					new SqlParameter("@ContentDescription", SqlDbType.NVarChar,-1),
					new SqlParameter("@AurhorDescription", SqlDbType.NVarChar,-1),
					new SqlParameter("@EditorComment", SqlDbType.NVarChar,-1),
					new SqlParameter("@TOC", SqlDbType.NVarChar,-1),
					new SqlParameter("@Registration", SqlDbType.Int,4),
					new SqlParameter("@IsShow", SqlDbType.Int,4),
					new SqlParameter("@Price", SqlDbType.Decimal,9),
					new SqlParameter("@StartDate", SqlDbType.DateTime),
					new SqlParameter("@beiyong", SqlDbType.NVarChar,-1),
					new SqlParameter("@IsRecommended", SqlDbType.Int,4)};
			parameters[0].Value = model.Title;
			parameters[1].Value = model.Author;
			parameters[2].Value = model.CategoryId;
			parameters[3].Value = model.Clicks;
			parameters[4].Value = model.PublishDate;
			parameters[5].Value = model.Duration;
			parameters[6].Value = model.ContentDescription;
			parameters[7].Value = model.AurhorDescription;
			parameters[8].Value = model.EditorComment;
			parameters[9].Value = model.TOC;
			parameters[10].Value = model.Registration;
			parameters[11].Value = model.IsShow;
			parameters[12].Value = model.Price;
			parameters[13].Value = model.StartDate;
			parameters[14].Value = model.beiyong;
			parameters[15].Value = model.IsRecommended;

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
		public bool Update(Maticsoft.Model.Course model)
		{
			StringBuilder strSql=new StringBuilder();
			strSql.Append("update Course set ");
			strSql.Append("Title=@Title,");
			strSql.Append("Author=@Author,");
			strSql.Append("CategoryId=@CategoryId,");
			strSql.Append("Clicks=@Clicks,");
			strSql.Append("PublishDate=@PublishDate,");
			strSql.Append("Duration=@Duration,");
			strSql.Append("ContentDescription=@ContentDescription,");
			strSql.Append("AurhorDescription=@AurhorDescription,");
			strSql.Append("EditorComment=@EditorComment,");
			strSql.Append("TOC=@TOC,");
			strSql.Append("Registration=@Registration,");
			strSql.Append("IsShow=@IsShow,");
			strSql.Append("Price=@Price,");
			strSql.Append("StartDate=@StartDate,");
			strSql.Append("beiyong=@beiyong,");
			strSql.Append("IsRecommended=@IsRecommended");
			strSql.Append(" where Id=@Id");
			SqlParameter[] parameters = {
					new SqlParameter("@Title", SqlDbType.NVarChar,200),
					new SqlParameter("@Author", SqlDbType.NVarChar,200),
					new SqlParameter("@CategoryId", SqlDbType.Int,4),
					new SqlParameter("@Clicks", SqlDbType.Int,4),
					new SqlParameter("@PublishDate", SqlDbType.DateTime),
					new SqlParameter("@Duration", SqlDbType.Int,4),
					new SqlParameter("@ContentDescription", SqlDbType.NVarChar,-1),
					new SqlParameter("@AurhorDescription", SqlDbType.NVarChar,-1),
					new SqlParameter("@EditorComment", SqlDbType.NVarChar,-1),
					new SqlParameter("@TOC", SqlDbType.NVarChar,-1),
					new SqlParameter("@Registration", SqlDbType.Int,4),
					new SqlParameter("@IsShow", SqlDbType.Int,4),
					new SqlParameter("@Price", SqlDbType.Decimal,9),
					new SqlParameter("@StartDate", SqlDbType.DateTime),
					new SqlParameter("@beiyong", SqlDbType.NVarChar,-1),
					new SqlParameter("@IsRecommended", SqlDbType.Int,4),
					new SqlParameter("@Id", SqlDbType.Int,4)};
			parameters[0].Value = model.Title;
			parameters[1].Value = model.Author;
			parameters[2].Value = model.CategoryId;
			parameters[3].Value = model.Clicks;
			parameters[4].Value = model.PublishDate;
			parameters[5].Value = model.Duration;
			parameters[6].Value = model.ContentDescription;
			parameters[7].Value = model.AurhorDescription;
			parameters[8].Value = model.EditorComment;
			parameters[9].Value = model.TOC;
			parameters[10].Value = model.Registration;
			parameters[11].Value = model.IsShow;
			parameters[12].Value = model.Price;
			parameters[13].Value = model.StartDate;
			parameters[14].Value = model.beiyong;
			parameters[15].Value = model.IsRecommended;
			parameters[16].Value = model.Id;

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
			strSql.Append("delete from Course ");
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
			strSql.Append("delete from Course ");
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
		public Maticsoft.Model.Course GetModel(int Id)
		{
			
			StringBuilder strSql=new StringBuilder();
			strSql.Append("select  top 1 Id,Title,Author,CategoryId,Clicks,PublishDate,Duration,ContentDescription,AurhorDescription,EditorComment,TOC,Registration,IsShow,Price,StartDate,beiyong,IsRecommended from Course ");
			strSql.Append(" where Id=@Id");
			SqlParameter[] parameters = {
					new SqlParameter("@Id", SqlDbType.Int,4)
			};
			parameters[0].Value = Id;

			Maticsoft.Model.Course model=new Maticsoft.Model.Course();
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
		public Maticsoft.Model.Course DataRowToModel(DataRow row)
		{
			Maticsoft.Model.Course model=new Maticsoft.Model.Course();
			if (row != null)
			{
				if(row["Id"]!=null && row["Id"].ToString()!="")
				{
					model.Id=int.Parse(row["Id"].ToString());
				}
				if(row["Title"]!=null)
				{
					model.Title=row["Title"].ToString();
				}
				if(row["Author"]!=null)
				{
					model.Author=row["Author"].ToString();
				}
				if(row["CategoryId"]!=null && row["CategoryId"].ToString()!="")
				{
					model.CategoryId=int.Parse(row["CategoryId"].ToString());
				}
				if(row["Clicks"]!=null && row["Clicks"].ToString()!="")
				{
					model.Clicks=int.Parse(row["Clicks"].ToString());
				}
				if(row["PublishDate"]!=null && row["PublishDate"].ToString()!="")
				{
					model.PublishDate=DateTime.Parse(row["PublishDate"].ToString());
				}
				if(row["Duration"]!=null && row["Duration"].ToString()!="")
				{
					model.Duration=int.Parse(row["Duration"].ToString());
				}
				if(row["ContentDescription"]!=null)
				{
					model.ContentDescription=row["ContentDescription"].ToString();
				}
				if(row["AurhorDescription"]!=null)
				{
					model.AurhorDescription=row["AurhorDescription"].ToString();
				}
				if(row["EditorComment"]!=null)
				{
					model.EditorComment=row["EditorComment"].ToString();
				}
				if(row["TOC"]!=null)
				{
					model.TOC=row["TOC"].ToString();
				}
				if(row["Registration"]!=null && row["Registration"].ToString()!="")
				{
					model.Registration=int.Parse(row["Registration"].ToString());
				}
				if(row["IsShow"]!=null && row["IsShow"].ToString()!="")
				{
					model.IsShow=int.Parse(row["IsShow"].ToString());
				}
				if(row["Price"]!=null && row["Price"].ToString()!="")
				{
					model.Price=decimal.Parse(row["Price"].ToString());
				}
				if(row["StartDate"]!=null && row["StartDate"].ToString()!="")
				{
					model.StartDate=DateTime.Parse(row["StartDate"].ToString());
				}
				if(row["beiyong"]!=null)
				{
					model.beiyong=row["beiyong"].ToString();
				}
				if(ExistsColumn(row, "IsRecommended"))
				{
					if(row["IsRecommended"]!=null && row["IsRecommended"].ToString()!="")
					{
						model.IsRecommended=int.Parse(row["IsRecommended"].ToString());
					}
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
			strSql.Append("select Id,Title,Author,CategoryId,Clicks,PublishDate,Duration,ContentDescription,AurhorDescription,EditorComment,TOC,Registration,IsShow,Price,StartDate,beiyong,IsRecommended ");
			strSql.Append(" FROM Course ");
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
			strSql.Append(" Id,Title,Author,CategoryId,Clicks,PublishDate,Duration,ContentDescription,AurhorDescription,EditorComment,TOC,Registration,IsShow,Price,StartDate,beiyong,IsRecommended ");
			strSql.Append(" FROM Course ");
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
			strSql.Append("select count(1) FROM Course ");
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
			strSql.Append(")AS Row, T.*  from Course T ");
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
			parameters[0].Value = "Course";
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

		private bool ExistsColumn(DataRow row, string columnName)
		{
			try
			{
				return row.Table.Columns.Contains(columnName);
			}
			catch
			{
				return false;
			}
		}

		#endregion  ExtensionMethod
	}
}

