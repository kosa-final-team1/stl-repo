document.addEventListener('DOMContentLoaded', function() {
    const seasonFilter = document.getElementById('seasonFilter');
    const categoryFilter = document.getElementById('categoryFilter');
    const outfitCards = document.querySelectorAll('.outfit-card');

    function filterOutfits() {
        const selectedSeason = seasonFilter ? seasonFilter.value : '';
        const selectedCategory = categoryFilter ? categoryFilter.value : '';

        outfitCards.forEach(card => {
            const cardSeason = card.dataset.season;
            const cardCategory = card.dataset.category;

            const seasonMatch = selectedSeason === '' || cardSeason === selectedSeason;
            const categoryMatch = selectedCategory === '' || cardCategory === selectedCategory;

            card.style.display = (seasonMatch && categoryMatch) ? 'block' : 'none';
        });
    }

    // 필터가 존재하는 경우에만 필터링을 적용
    if (seasonFilter || categoryFilter) {
        filterOutfits();
        if (seasonFilter) {
            seasonFilter.addEventListener('change', filterOutfits);
        }
        if (categoryFilter) {
            categoryFilter.addEventListener('change', filterOutfits);
        }
    }

    // 스크롤 이벤트 리스너
    window.addEventListener('scroll', function() {
        const header = document.querySelector('header');
        header.classList.toggle('scrolled', window.scrollY > 50);
    });
});