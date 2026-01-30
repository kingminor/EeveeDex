using Npgsql;
using System.Data;

namespace EeveeDex.Services {
    public class DbService {
        private readonly string _connectionString;

        public DbService(IConfiguration config) {
            _connectionString = config.GetConnectionString("PokemonDb");
        }

        public DataTable ExecuteQuery(string sql) {
            using var conn = new NpgsqlConnection(_connectionString);
            using var cmd = new NpgsqlCommand(sql, conn);
            using var da = new NpgsqlDataAdapter(cmd);
            var dt = new DataTable();
            da.Fill(dt);
            return dt;
        }

        public int ExecuteNonQuery(string sql) {
            using var conn = new NpgsqlConnection(_connectionString);
            using var cmd = new NpgsqlCommand(sql, conn);
            conn.Open();
            return cmd.ExecuteNonQuery();
        }
    }
}