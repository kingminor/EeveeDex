using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Data;
using EeveeDex.Services;

namespace EeveeDex.Pages;

public class PokemonModel : PageModel
{
    private readonly DbService _db;

    public DataTable Species { get; set; }

    public PokemonModel(DbService db)
    {
        _db = db;
    }
    
    public void OnGet()
    {
            Species = _db.ExecuteQuery(@"
                                SELECT 
                                    s.id,
                                    s.pokedex_number,
                                    s.name,
                                    s.classification,
                                    s.generation,
                                    i.url AS image_url,
                                    so.url AS sound_url,
                                    STRING_AGG(t.name, ',') AS types
                                FROM species s
                                LEFT JOIN image i 
                                    ON s.id = i.species_id 
                                    AND i.is_default = TRUE
                                LEFT JOIN sound so
                                    ON s.id = so.species_id
                                    AND so.is_default = TRUE
                                LEFT JOIN species_has_type sht
                                    ON s.id = sht.species_id
                                LEFT JOIN type t
                                    ON sht.type_id = t.id
                                GROUP BY 
                                    s.id, s.pokedex_number, s.name, s.classification, s.generation, i.url, so.url
                                ORDER BY s.pokedex_number;
                            ");

    }
}