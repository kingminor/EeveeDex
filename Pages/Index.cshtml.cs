using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Data;
using EeveeDex.Services;

namespace EeveeDex.Pages;

public class IndexModel : PageModel
{
    private readonly DbService _db;

    public DataTable Species { get; set; }

    public IndexModel(DbService db)
    {
        _db = db;
    }

    public void OnGet()
    {
        Species = _db.ExecuteQuery("SELECT name, pokedex_number, classification FROM species ORDER BY pokedex_number;");
    }
}
