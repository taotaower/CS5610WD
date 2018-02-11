defmodule Memory.Game do

  def initialGrids do

   grinds = Enum.shuffle([%{id: 0, value: "A", matched: false, flipped: false},
     %{id: 1, value: "B", matched: false, flipped: false},
     %{id: 2, value: "C", matched: false, flipped: false},
     %{id: 3, value: "D", matched: false, flipped: false},
     %{id: 4, value: "E", matched: false, flipped: false},
     %{id: 5, value: "F", matched: false, flipped: false},
     %{id: 6, value: "G", matched: false, flipped: false},
     %{id: 7, value: "H", matched: false, flipped: false},
     %{id: 8, value: "A", matched: false, flipped: false},
     %{id: 9, value: "B", matched: false, flipped: false},
     %{id: 10, value: "C", matched: false, flipped: false},
     %{id: 11, value: "D", matched: false, flipped: false},
     %{id: 12, value: "E", matched: false, flipped: false},
     %{id: 13, value: "F", matched: false, flipped: false},
     %{id: 14, value: "G", matched: false, flipped: false},
     %{id: 15, value: "H", matched: false, flipped: false}])
            |> Enum.with_index
            |> Enum.map(fn({e, index}) -> Map.replace!(e, :id, index) end)

   %{grinds: grinds,
     lastGrind: nil,
     locked: false,
     matches: 0,
     tryTimes: 0,}

#   a=List.first(grinds)
#   IO.inspect {:a, a}
#   a = Map.put(a,:id, 100)
#   IO.inspect {:a, a}


#   IO.inspect {grinds,List.first(grinds).id}

    end





  def lastGrind(id,value,state) do

    %{grinds: state.grinds,
      lastGrind: %{id: id,value: value},
      locked: false,
      matches: state.matches,
      tryTimes: state.tryTimes,}

  end

def flipLock(id,state) do
    grinds = state.grinds
    updateGri = Map.put(Enum.fetch!(grinds,id),:flipped, true)
    grinds = List.replace_at(grinds, id, updateGri)

    %{grinds: grinds,
      lastGrind: state.lastGrind,
      locked: true,
      matches: state.matches,
      tryTimes: state.tryTimes,}

  end


def setMatch(id,last_id,state) do
    grinds = state.grinds
    updateGri = Map.put(Enum.fetch!(grinds,id),:matched, true)
    grinds = List.replace_at(grinds, id, updateGri)

    updateGriLast = Map.put(Enum.fetch!(grinds,last_id),:matched, true)
    grinds = List.replace_at(grinds, last_id, updateGriLast)
    %{grinds: grinds,
      lastGrind: nil,
      locked: false,
      matches: state.matches + 1,
      tryTimes: state.tryTimes + 1,}

  end


  def setNoMatch(id,last_id,state) do
    grinds = state.grinds
    updateGri = Map.put(Enum.fetch!(grinds,id),:flipped, false)
    grinds = List.replace_at(grinds, id, updateGri)

    updateGriLast = Map.put(Enum.fetch!(grinds,last_id),:flipped, false)
    grinds = List.replace_at(grinds, last_id, updateGriLast)

    %{grinds: grinds,
      lastGrind: nil,
      locked: false,
      matches: state.matches,
      tryTimes: state.tryTimes + 1,}

  end

#def checkEqual(value,id,state)do
#
#    grinds = state.grinds
#    updateGri = Map.put(Enum.fetch(grinds,id),:flipped, true)
#    grinds = List.replace_at(grinds, id, updateGri)
#    locked = true
#
#    if state.lastGrind do
#      tryTimes = state.tryTimes + 1
#
#
#    else
#
#      %{grinds: grinds,
#        lastGrind: %{id,value},
#        locked: false,
#        matches: 0,
#        tryTimes: 0,}
#
#    end
#
#  end


end
