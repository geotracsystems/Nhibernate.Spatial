using System.Collections.Generic;
using NHibernate.Cfg;
using NHibernate.Driver;
using NHibernate.Spatial.Dialect;
using Environment = NHibernate.Cfg.Environment;
using Settings = Tests.NHibernate.Spatial.Properties.Settings;
using NHibernateFactory = NHibernate.Bytecode.DefaultProxyFactoryFactory;

namespace Tests.NHibernate.Spatial
{
	internal static class TestConfiguration
	{
		public static void Configure(Configuration configuration)
		{
			IDictionary<string, string> properties = new Dictionary<string, string>();
            properties[Environment.ProxyFactoryFactoryClass] = typeof(NHibernateFactory).AssemblyQualifiedName;
			properties[Environment.Dialect] = typeof(MsSqlSpatialDialect).AssemblyQualifiedName;
			properties[Environment.ConnectionProvider] = typeof(DebugConnectionProvider).AssemblyQualifiedName;
			properties[Environment.ConnectionDriver] = typeof(SqlClientDriver).AssemblyQualifiedName;
			properties[Environment.ConnectionString] = Settings.Default.ConnectionString;
			//properties[Environment.Hbm2ddlAuto] = "create-drop";
			configuration.SetProperties(properties);
		}

	}
}
