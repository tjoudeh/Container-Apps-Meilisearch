using System.Text.Json;

namespace Meilisearch.Console
{
    public class Movie
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Poster { get; set; }
        public string Overview { get; set; }
        public IEnumerable<string> Genres { get; set; }
    }

    internal class Program
    {
        static async Task Main(string[] args)
        {

            MeilisearchClient client = new MeilisearchClient("https://<fqdn>.<location>.azurecontainerapps.io", "<MASTER API KEY>");
            var options = new JsonSerializerOptions
            {
                PropertyNameCaseInsensitive = true
            };

            string jsonString = await File.ReadAllTextAsync(@"movies.json");
            var movies = JsonSerializer.Deserialize<IEnumerable<Movie>>(jsonString, options);

            var index = client.Index("movies");

            var newSettings = new Settings
            {
                FilterableAttributes = new string[] { "genres" },
                SortableAttributes = new string[] { "title" },
            };

            await index.UpdateSettingsAsync(newSettings);

            await index.AddDocumentsAsync<Movie>(movies,"id");
        }
    }
}