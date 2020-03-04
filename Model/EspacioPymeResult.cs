using System;
using System.Collections.Generic;

namespace Camarco.Model
{
	public class EspacioPymeResult
	{
		public int SeccionID
		{
			get;
			set;
		}

		public string Color
		{
			get;
			set;
		}

		public List<Resource> Items
		{
			get;
			set;
		}

		public EspacioPymeResult(int s, string c)
		{
			this.SeccionID = s;
			this.Color = c;
			this.Items = new List<Resource>();
		}
	}
}
