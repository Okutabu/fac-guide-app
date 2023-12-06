from fuzzywuzzy import process
import json

class Batiments:
    def __init__(self, numero, nom, entree):
        self.numero = numero
        self.nom = nom
        self.entree = entree

def suggest_results(batiments, query):
    query_lower = query.lower()  # Convertit la chaîne de recherche en minuscules

    all_values = [batiment.numero.lower() for batiment in batiments] + [batiment.nom.lower() for batiment in batiments]
    
    # Filtrer les valeurs en fonction de la chaîne de recherche
    filtered_values = [value for value in all_values if query_lower in value]

    # Obtient uniquement les valeurs suggérées
    suggestions = process.extract(query_lower, filtered_values, limit=5)

    # Obtient uniquement les valeurs suggérées (première valeur du tuple)
    suggested_values = [suggestion[0] for suggestion in suggestions]

    # Filtrer les batiments en fonction des valeurs suggérées
    suggested_batiments = [batiment for batiment in batiments if batiment.numero.lower() in suggested_values or batiment.nom.lower() in suggested_values]

    # Récupère la première "entree" de chaque batiment suggéré
    suggested_entrees = [{"numero": batiment.numero, "nom": batiment.nom, "entree": batiment.entree[0] if batiment.entree else None} for batiment in suggested_batiments]

    # Enregistre le JSON dans un fichier
    with open("suggest_bat.json", "w") as output_file:
        json.dump({"batiments": suggested_entrees}, output_file, indent=2)

    if (suggested_values == []):
        all_values = [batiment.numero for batiment in batiments] + [batiment.nom for batiment in batiments]
        suggestions = process.extract(query, all_values, limit=5)

        # Obtient uniquement les valeurs suggérées (première valeur du tuple)
        suggested_values = [suggestion[0] for suggestion in suggestions]

        # Filtrer les batiments en fonction des valeurs suggérées
        suggested_batiments = [batiment for batiment in batiments if batiment.numero in suggested_values or batiment.nom in suggested_values]

        # Récupère la première "entree" de chaque batiment suggéré
        suggested_entrees = [{"numero": batiment.numero, "nom": batiment.nom, "entree": batiment.entree[0] if batiment.entree else None} for batiment in suggested_batiments]

        # Enregistre le JSON dans un fichier
        with open("suggest_bat.json", "w") as output_file:
            json.dump({"batiments": suggested_entrees}, output_file, indent=2)

    return suggested_values





# Exemple d'utilisation
if __name__ == "__main__":
    # Charge les données JSON depuis un fichier (remplacez le chemin par le vôtre)
    with open("bat.json", "r") as file:
        json_data = json.load(file)

    # Crée des objets Batiment à partir des données JSON
    batiments = [Batiments(batiment["numero"], batiment["nom"], batiment.get("entree", [])) for batiment in json_data.get("batiments", [])]

    # Chaîne de recherche partielle entrée par l'utilisateur
    query = "8 d"

    # Obtient les suggestions basées sur les attributs numero et nom des objets Batiment
    suggestions = suggest_results(batiments, query)

    # Affiche les suggestions
    print("Suggestions de recherche:", suggestions)