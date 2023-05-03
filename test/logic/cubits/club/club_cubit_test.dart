/*
group('Club Repository Test',(){
late ClubCubit clubCubit;
late clubs clubs;

setUp((){
clubCubit = ClubCubit();
clubs = [];
});

test('init', (){
expect(clubCubit.state, const ClubLoadInProgress());
});


blocTest<ClubCubit,ClubState>(
'getAllClubs',
build:() => clubClubit,
act: (cubit) => cubit.getAllClubs(),
expect: () => const <ClubState>[ClubLoadSuccess(clubs)]
);

});
*/