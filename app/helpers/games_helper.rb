module GamesHelper

    def tabelfy_game(game)
        
        <<-TABLE_HTML
            <table>
                <tr>
                    <td>Title</td>
                    #{game.title}
                </tr>
            </table>
        
        TABLE_HTML
    end

end