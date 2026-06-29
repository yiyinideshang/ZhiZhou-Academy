using System;
namespace Maticsoft.Model
{
	[Serializable]
	public partial class Cart
	{
		public Cart()
		{}
		#region Model
		private int _id;
		private int _userid;
		private int _courseid;
		private DateTime _addtime;
		public int Id
		{
			set{ _id=value;}
			get{return _id;}
		}
		public int UserId
		{
			set{ _userid=value;}
			get{return _userid;}
		}
		public int CourseId
		{
			set{ _courseid=value;}
			get{return _courseid;}
		}
		public DateTime AddTime
		{
			set{ _addtime=value;}
			get{return _addtime;}
		}
		#endregion Model
	}
}
