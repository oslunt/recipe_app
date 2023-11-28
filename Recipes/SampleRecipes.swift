//
//  SampleRecipes.swift
//  Recipes
//
//  Created by IS 543 on 11/28/23.
//

import Foundation

// See https://stackoverflow.com/questions/24410881/reading-in-a-json-file-using-swift#:~:text=struct%20ResponseData%3A,return%20nil%0A%7D

struct ResponseData: Decodable {
    var recipes: [SampleRecipe]
}

struct SampleRecipe : Decodable {
    var title: String
    var ingredients: String
    var instructions: String
}

func loadJson(filename fileName: String) -> [SampleRecipe]? {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let jsonData = try JSONDecoder().decode(ResponseData.self, from: data)
            return jsonData.recipes
        } catch {
            print("error: \(error)")
        }
    }
    return nil
}
let sampleRecipes = [
    Item(
        title: "Pfeffernüsse",
        ingredients:"""
            | Quantity       | Ingredient                                                    |
            | --- | --- |
            | 320g           | Bread flour                                                   |
            | scant 1 tsp.   | Baking soda                                                   |
            | 1 tsp.         | Salt                                                          |
            | 4 tsp.         | Lebkuchengewürz                                               |
            | 1 tsp.         | *Ground ginger                                                |
            | 1 tsp.         | White pepper                                                  |
            | 1 tsp.         | *Black pepper                                                 |
            | 30g            | Almond meal                                                   |
            | 100g           | Brown sugar                                                   |
            | 113g           | Honey                                                         |
            | 71g (5 Tbsp.)  | Unsalted butter                                               |
            | 50g (3 Tbsp.)  | Heavy cream                                                   |
            | 25g (1+ Tbsp.) | Molasses                                                      |
            | 2 large        | Eggs                                                          |

            | **Glaze:**     |                                                               |
            | --- | --- |
            | 300g           | Powdered sugar                                                |
            | 4 Tbsp.        | Hot water or juice and zest of 1-2 lemons (I prefer lemon juice over hot water) |
            """,
        instructions:"""
        ## Instructions

        1. **Mix Dry Ingredients:** In a small bowl, mix the dry ingredients together.
        2. **Combine Wet Ingredients:** In a saucepan, combine all wet ingredients except the egg. Heat the mixture, stirring frequently, until everything is melted and the sugar has dissolved. Remove from heat and let it sit for 5 minutes to cool slightly.
        3. **Combine Wet and Dry Mixtures:** Add the dry ingredients to the wet mixture in the saucepan, and then incorporate the egg. Mix until well combined.
        4. **Refrigerate the Dough:** Wrap the dough in cling film and refrigerate for 24-48 hours to allow the flavors to blend and the dough to mature.
        5. **Form the Cookies:** Once the dough is chilled, roll it into two 4-inch thick 'snakes' and cut these into 4-inch long 'slugs' (approximately 17g each). Roll these pieces into balls and place them on a baking sheet lined with silicone or parchment paper. Chill in the refrigerator for an additional 20-30 minutes.
        6. **Bake:** Preheat the oven to 375 degrees F (190 degrees C). Bake the chilled dough balls for approximately 10 minutes.
        7. **Cool and Glaze:** Allow the baked cookies to cool completely. Then, dip them into the glaze of your choice. If the glaze is too thick, thin it with a little hot water until you reach the desired consistency.

        **Note:** For a milder flavor, omit the ginger and black pepper. To add more 'kick,' increase the quantities of these spices according to your taste.

        **Optional Decoration:** Consider adding a chocolate drizzle, orange zest, and lemon zest for extra flavor and decoration.

        ## Lebkuchengewürz (German Gingerbread Spice Blend)

        For the authentic Lebkuchengewürz recipe, visit:
        [Homemade Lebkuchengewürz](https://www.daringgourmet.com/homemade-lebkuchengewuerz-german-gingerbread-spice-blend/)

        """
    ),
    Item(
    title: "Nürnberger Elisenlebkuchen (German Lebkuchen)",
    ingredients: """
    - 5 large eggs
    - 275 g packed brown sugar
    - 85 ml honey
    - 1 teaspoon vanilla extract
    - 225 g almond meal
    - 225 g hazelnut meal
    - 4 teaspoon salt
    - 1 teaspoon baking powder
    - 3 teaspoons Lebkuchengewürz
    - 115 g candied lemon peel
    - 115 g candied orange peel
    - 4 cups all-purpose flour (to coat the candied peel)
    - Backoblaten, 70mm
    - Blanched whole almonds cut in half lengthwise

    **For the Chocolate Glaze:**
    - 85 g quality dark or milk chocolate
    - 1 tablespoon coconut oil

    **Directions:** Place chocolate and oil in a small bowl and microwave, stirring occasionally, until melted. Use immediately. If glaze becomes firm, reheat in the microwave.

    **For the Sugar Glaze:**
    - 120 g sifted powdered sugar
    - 3 tablespoons water

    **Directions:** Place sugar and water in a small bowl and stir until smooth.

    """,
    instructions:
    """

    ## Instructions

    1. **Preparation:** Preheat the oven to 300 degrees F (150 degrees C).
    2. **Candied Peel:** Toss the candied lemon and orange peel with about 1 cup all-purpose flour to keep it from sticking together. Then, pulse in a food processor until finely minced. Set aside.
    3. **Egg Mixture:** In a large mixing bowl, beat the eggs until foamy. Add the sugar, honey, and vanilla extract, beating until combined.
    4. **Dry Ingredients:** Add the ground almonds, hazelnuts, salt, baking powder, Lebkuchengewürz, and the minced candied lemon and orange peels to the egg mixture. Stir vigorously until thoroughly combined. If the mixture is too thin, add more almond or hazelnut meal.
    5. **Baking:** Scoop the mixture onto the Backoblaten, smoothing down the top and leaving just a slight space around the edges. Place them on a lined cookie sheet and bake on the middle rack for 25-28 minutes.
    6. **Cooling:** After baking, remove the cookie sheet and allow to cool completely.
    7. **Glazing:** Once cooled, dip half the Lebkuchen in the chocolate glaze and half in the sugar glaze. Let the excess glaze drip off before placing them on a wire rack to dry. Arrange 3 almond halves on each Lebkuchen while the glaze is still wet.
    8. **Storage:** Once the glaze has hardened, store the Lebkuchen in an airtight container. They will keep for several weeks, and the flavor improves with time.

    ## Yield

    - Makes about 35 Lebkuchen.

    ## Notes

    - The batter should be thick enough to scoop, but not runny.
    - Adjust the amount of almond or hazelnut meal if necessary to achieve the right consistency.
    - The flavor of the Lebkuchen develops and improves over time, so these are great for making ahead.
    """)
]
